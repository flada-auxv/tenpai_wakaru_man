module TenpaiWakaruMan
  class Hand
    attr_accessor :head, :tiles, :sets

    class << self
      def build(tile_str)
        Parser.parse(tile_str)
      end
    end

    def initialize(head: nil, tiles: [], sets: [])
      @head  = head
      @tiles = tiles
      @sets  = sets
    end

    def ==(other)
      head == other.head && tiles == other.tiles && sets == other.sets
    end

    def <<(tiles)
      case tiles
      when Array
        @tiles = (@tiles + tiles).sort_by {|tile| TILES[tile] }
      when Set
        @sets.push(tiles)
      end
    end

    def dup
      self.class.new(head: head&.dup, tiles: tiles.dup, sets: sets.dup)
    end

    def inspect
      "#<#{self.class.name}:\"#{to_msp_notation}\", @head=#{@head.inspect}, @sets=#{@sets.map(&:to_s)}, @tiles=#{@tiles}>"
    end

    def to_msp_notation
      ([Set.new(@tiles)] + @sets).sort.map(&:msp_notation).join
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
      set_combination.map {|sets| self.class.new(head: @head.dup, sets: sets) }.select {|hand| hand.all_tiles == all_tiles }
    end

    def set_head(tile)
      self.head = tile
      @tiles.slice!(@tiles.index(tile), 2)

      self
    end

    def all_tiles
      @all_tiles ||= (tiles + sets.map(&:tiles)).flatten.sort_by {|tile| TILES[tile] }
    end

    def seven_pairs?
      count_by.keys.count == 7 && count_by.values.all? {|i| i == 2 }
    end

    def thirteen_orphans?
      count_by.keys.count == 13
    end

    private

    def head_candidates
      @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
    end

    def set_candidates
      @tiles.combination(3).map {|tiles| Set.new(tiles) }.select {|set| set.pong? || set.chow? }
    end

    def set_combination
      (@sets + set_candidates).combination(4).to_a.uniq {|set_arr| set_arr.map(&:tiles).hash }
    end

    def count_by
      @count_by ||= @tiles.group_by {|tile| tile }.each_with_object({}) {|(k,v), hash| hash[k] = v.count }
    end

    def detect_special_form!
      @ready_hands = Array(dup) if thirteen_orphans? || seven_pairs?
    end
  end
end
