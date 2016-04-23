require "tenpai_wakaru_man/tiles"
require "tenpai_wakaru_man/parser"

module TenpaiWakaruMan
  class Set
    attr_accessor :tiles, :tile_str

    def initialize(tiles)
      case tiles
      when String
        @tile_str = tiles
        @tiles = Parser.split(@tile_str)
      when Array
        @tiles = tiles.sort_by {|tile| TILES[tile] }
        @tile_str = Parser.to_msp_notation(@tiles)
      end

      @unique_count = @tiles.uniq.count
      @count = @tiles.count
    end

    def ==(other)
      @tile_str == other.tile_str
    end

    def <=>(other)
      @tiles.hash <=> other.tiles.hash
    end

    def inspect
      "#<#{self.class.name}:\"#{@tile_str}\">"
    end

    def pair?
      @unique_count == 1 && @count == 2
    end

    def pong?
      @unique_count == 1 && @count == 3
    end

    def kong?
      @unique_count == 1 && @count == 4
    end

    def chow?
      return false unless @tiles.map {|tile| tile[-1] }.uniq.count == 1

      chow_candidates = @tiles.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

      return false unless chow_candidates.uniq.count == 3

      [chow_candidates[0] + 2,  chow_candidates[1] + 1, chow_candidates[2]].uniq.count == 1
    end

    def melded?
      @melded ||= !!@tile_str[/[#{Parser::MELDED_SYMBOLS}]/]
    end
  end
end
