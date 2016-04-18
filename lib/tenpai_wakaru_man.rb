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
    end

    def initialize(tiles)
      @tiles = tiles
      parse!
    end

    def tenpai?
      true
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
