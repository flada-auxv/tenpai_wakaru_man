module TenpaiWakaruMan
  class Hand
    attr_accessor :tiles, :sets, :head

    def initialize(tiles: [], head: nil, sets: [])
      @tiles = tiles
      @sets  = sets
      @head  = head
    end

    def ==(other)
      tiles == other.tiles && sets == other.sets
    end

    def <<(tiles)
      case tiles
      when Array
        @tiles = (@tiles + tiles).sort_by {|tile| TILES[tile] }
      when Set
        @sets.push(tiles)
      end
    end

    def head_candidates
      @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
    end

    def ready?
      !ready_hands.empty?
    end

    def ready_hands
      head_candidates.map {|head|
        self.head = head
        hand = dup
        hand.tiles.slice!(hand.tiles.index(head), 2)

        hand
      }.select {|hand| !detect(hand).empty? }
    end

    def detect(hand)
      sets = hand.tiles.combination(3).map {|tiles| Set.new(tiles) }.select {|set| set.pong? || set.chow? }
      (sets + hand.sets).combination(4).select {|set_arr|
        set_arr.map(&:tiles).flatten.sort_by {|tile| TILES[tile] } ==  hand.all_tiles
      }
    end

    def all_tiles
      @all_tiles ||= (tiles + sets.map(&:tiles)).flatten.sort_by {|tile| TILES[tile] }
    end

    def dup
      self.class.new(tiles: tiles.dup, sets: sets.dup, head: head.dup)
    end
  end
end
