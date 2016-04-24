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
      @melds  = melds

      check_tile_count!
    end

    def ==(other)
      head == other.head && tiles == other.tiles && melds == other.melds
    end

    def dup
      self.class.new(head: head&.dup, tiles: tiles.dup, melds: melds.dup)
    end

    def inspect
      "#<#{self.class.name}:\"#{to_msp_notation}\", @head=#{@head.inspect}, @melds=#{@melds.map(&:to_s)}, @tiles=#{@tiles}>"
    end

    def to_msp_notation
      ([Meld.new(@tiles)] + @melds).sort.map(&:msp_notation).join
    end
    alias :to_s :to_msp_notation

    def ready?
      !ready_hands.empty?
    end

    def ready_hands
      detect_special_form!

      @ready_hands ||= head_candidates.map {|head| dup.set_head(head) }.map {|hand| hand.detect_ready_hands }.reject(&:empty?).flatten
    end

    def detect_ready_hands
      meld_combination.map {|melds| self.class.build(head: @head.dup, melds: melds) }.compact.select {|hand| hand.all_tiles == all_tiles }
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
      count_by.keys.count == 13 && all_tiles.all? {|tile| tile[/[#{Parser::HONOR_SYMBOLS}]/] || tile[/[19]/] }
    end

    private

    def head_candidates
      @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
    end

    def meld_candidates
      @tiles.combination(3).map {|tiles| Meld.new(tiles) }.select {|meld| meld.triplet? || meld.run? }
    end

    def meld_combination
      (@melds + meld_candidates).combination(4).to_a.uniq {|meld_arr| meld_arr.map(&:tiles).hash }
    end

    def count_by
      all_tiles.group_by {|tile| tile }.each_with_object({}) {|(k,v), hash| hash[k] = v.count }
    end

    def detect_special_form!
      @ready_hands = Array(dup) if thirteen_orphans? || seven_pairs?
    end

    def check_tile_count!
      raise TileCountError.new('some tiles existing than four.') if count_by.any? {|key, count| count > 4 }
    end
  end
end
