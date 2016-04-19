require "tenpai_wakaru_man/version"

module TenpaiWakaruMan
  class Detector
    attr_accessor :tiles

    TILES = {
      "Ew" => 0,  "Sw" => 1,  "Ww" => 2,  "Nw" => 3,
      "Cd" => 4,  "Fd" => 5,  "Pd" => 6,
      "1m" => 7,  "2m" => 8,  "3m" => 9,  "4m" => 10, "5m" => 11, "6m" => 12, "7m" => 13, "8m" => 14, "9m" => 15,
      "1s" => 16, "2s" => 17, "3s" => 18, "4s" => 19, "5s" => 20, "6s" => 21, "7s" => 22, "8s" => 23, "9s" => 24,
      "1p" => 25, "2p" => 26, "3p" => 27, "4p" => 28, "5p" => 29, "6p" => 30, "7p" => 31, "8p" => 32, "9p" => 33
    }.freeze

    class << self
      def tenpai?(str)
        new(str).tenpai?
      end

      def select_mentsu(mentsu_arr)
        mentsu_arr.select {|mentsu| triplet?(mentsu) || sequence?(mentsu) }
      end

      def sequence?(mentsu)
        return false unless mentsu.map {|str| str[-1] }.uniq.count == 1

        sequence_candidates = mentsu.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

        return false unless sequence_candidates.uniq.count == 3

        [sequence_candidates[0] + 2,  sequence_candidates[1] + 1, sequence_candidates[2]].uniq.count == 1
      end

      def triplet?(mentsu)
        mentsu.uniq.count == 1
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
      self.class.select_mentsu(hand.combination(3)).to_a.combination(4).select {|mentsu_arr|
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
