require "tenpai_wakaru_man/tiles"
require "tenpai_wakaru_man/scanner"

module TenpaiWakaruMan
  class Set
    attr_accessor :tiles, :tile_str

    class << self
      def pong?(tile_str); new(tile_str).pong? end
      def kong?(tile_str); new(tile_str).kong? end
      def chow?(tile_str); new(tile_str).chow? end
    end

    def initialize(tiles)
      case tiles
      when String
        @tile_str = tiles
        @tiles = Scanner.scan(@tile_str)
      when Array
        @tiles = tiles.sort_by {|tile| TILES[tile] }
        @tile_str = Scanner.join_tiles(@tiles)
      end
    end

    def ==(other)
      @tile_str == other.tile_str
    end

    def pair?
      @tiles.count == 2 && @tiles.uniq.count == 1
    end

    def pong?
      @tiles.count == 3 && @tiles.uniq.count == 1
    end

    def kong?
      @tiles.count == 4 && @tiles.uniq.count == 1
    end

    def chow?
      return false unless @tiles.map {|tile| tile[-1] }.uniq.count == 1
      chow_candidates = @tiles.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

      return false unless chow_candidates.uniq.count == 3

      [chow_candidates[0] + 2,  chow_candidates[1] + 1, chow_candidates[2]].uniq.count == 1
    end
  end
end
