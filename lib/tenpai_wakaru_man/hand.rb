require 'tenpai_wakaru_man/errors'

module TenpaiWakaruMan
  class Hand
    attr_accessor :head, :tiles, :melds

    class << self
      def build(head: nil, tiles: [], melds: [])
        new(head: head, tiles: tiles, melds: melds)
      rescue TileCountError
        nil
      end

      def parse_from(tile_str)
        Parser.parse(tile_str)
      end
    end

    def initialize(head: nil, tiles: [], melds: [])
      @head  = head
      @tiles = tiles.sort_by {|tile| TILES[tile] }
      @melds  = melds.sort

      check_tile_count!
    end

    def ==(other)
      head == other.head && tiles == other.tiles && melds == other.melds
    end
    alias_method :eql?, :==

    def hash
      [head, tiles, melds].hash
    end

    def dup
      self.class.new(head: head&.dup, tiles: tiles.dup, melds: melds.dup)
    end

    def inspect
      "#<Hand:\"#{to_msp_notation}\", @head=#{@head.inspect}, @melds=#{@melds.map(&:to_s)}, @tiles=#{@tiles}>"
    end

    def to_msp_notation
      ([Meld.new(@tiles)] + @melds).sort.map(&:msp_notation).join
    end
    alias :to_s :to_msp_notation

    def win?
      !winning_hands.empty?
    end

    def winning_hands
      detect_special_form!

      @winning_hands ||= head_candidates.map {|head| dup.set_head(head) }.map {|hand| hand.detect_winning_hands }.flatten
    end

    def detect_winning_hands
      each_with_rest((@melds + meld_pattern)).with_object([]) {|(meld, rest_candidates), result|
        rest_tiles = extract_meld(all_tiles, meld)
        result.push(*_detect_winning_hands(rest_candidates, Array(meld), rest_tiles))
      }.uniq
    end

    def ready?
      TILES.each_key.any? {|tile|
        hand = dup
        hand.tiles << tile
        hand.win?
      }
    end

    def set_head(tile)
      self.head = tile
      @tiles.slice!(@tiles.index(tile), 2)

      self
    end

    def closed?
      melds.all?(&:closed?)
    end

    def open?
      !closed?
    end

    def all_tiles
      (tiles + melds.map(&:tiles)).flatten.sort_by {|tile| TILES[tile] }
    end

    def seven_pairs?
      count_by.keys.count == 7 && count_by.values.all? {|i| i == 2 }
    end

    def thirteen_orphans?
      count_by.keys.count == 13 && all_tiles.all? {|tile| /[#{Parser::HONOR_SYMBOLS}19]/.match?(tile) }
    end

    private

    def _detect_winning_hands(candidates, current_result, tiles, result = [])
      return [] if (candidates.count + current_result.count) < 4

      each_with_rest(candidates).with_object(result) {|(meld, rest_candidates), result|
        next unless rest_tiles = extract_meld(tiles, meld)

        _current_result = current_result.dup << meld

        if _current_result.count == 4
          result << self.class.build(head: @head.dup, melds: _current_result)
        else
          _detect_winning_hands(rest_candidates, _current_result, rest_tiles, result)
        end
      }
    end

    def each_with_rest(array)
      if block_given?
        array.each_with_index {|elem, i| yield elem, array[i+1..-1] }
      else
        array.map.with_index {|elem, i| [elem, array[i+1..-1]] }.each
      end
    end

    def extract_meld(tiles, meld)
      copied = tiles.dup

      deleted = meld.tiles.map {|tile|
        (index = copied.find_index(tile)) ? copied.delete_at(index) : nil
      }

      deleted.compact.count == meld.tiles.count ? copied : nil
    end

    def head_candidates
      @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
    end

    def meld_pattern
      (triplet_pattern + run_pattern).sort
    end

    def triplet_pattern
      count_by.select {|tile, count| count >= 3 }.keys.map {|t| CompletedMeld.new([t, t, t]) }
    end

    def run_pattern
      @tiles.uniq.combination(3).each_with_object([]) {|tiles, res|
        meld = CompletedMeld.new(tiles)
        next unless meld.run?

        min = tiles.map {|tile| count_by[tile] }.min
        min.times { res << meld }
      }
    end

    def count_by
      all_tiles.group_by {|tile| tile }.each_with_object({}) {|(k,v), hash| hash[k] = v.count }
    end

    def detect_special_form!
      @winning_hands = Array(dup) if thirteen_orphans? || seven_pairs?
    end

    def check_tile_count!
      raise TileCountError.new('some tiles existing than four.') if count_by.any? {|key, count| count > 4 }
    end
  end
end
