require "tenpai_wakaru_man/version"
require "tenpai_wakaru_man/tiles"

module TenpaiWakaruMan
  class Detector
    attr_accessor :tiles

    class << self
      def tenpai?(str)
        new(str).tenpai?
      end

      def select_set(sets_arr)
        sets_arr.select {|set| set?(set) }
      end

      def set?(set)
        pong?(set) || chow?(set)
      end

      def chow?(set)
        return false unless set.map {|str| str[-1] }.uniq.count == 1

        chow_candidates = set.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

        return false unless chow_candidates.uniq.count == 3

        [chow_candidates[0] + 2,  chow_candidates[1] + 1, chow_candidates[2]].uniq.count == 1
      end

      def pong?(set)
        set.uniq.count == 1
      end
    end

    def initialize(tiles)
      @tiles = tiles
      parse!
    end

    def tenpai?
      !detect.empty?
    end

    def detect
      hand_candidates.select {|head, hand| !_detect(hand).empty? }
    end

    def _detect(hand)
      self.class.select_set(hand.combination(3)).to_a.combination(4).select {|mentsu_arr|
        mentsu_arr.flatten.sort_by {|tile| TILES[tile] } == hand
      }
    end

    def hand_candidates
      head_candidates.map {|head|
        _tiles = @tiles.dup
        _tiles.slice!(@tiles.index(head), 2)

        [head, _tiles]
      }
    end

    def head_candidates
      @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
    end

    def parse!
      @tiles = @tiles.scan(/\d+[mps]|[ESWN]+w?|[PFC]+d?/).map {|str|
        str.chop.chars.map {|s| s + str[-1] }
      }.flatten.sort_by {|tile| TILES[tile] }
    end
  end
end
