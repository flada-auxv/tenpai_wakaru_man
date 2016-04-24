require "tenpai_wakaru_man/tiles"
require "tenpai_wakaru_man/parser"

module TenpaiWakaruMan
  class Meld
    attr_accessor :tiles, :msp_notation

    def initialize(tiles)
      case tiles
      when String
        @msp_notation = tiles
        @tiles = Parser.split(@msp_notation)
      when Array
        @tiles = tiles.sort_by {|tile| TILES[tile] }
        @msp_notation = to_msp_notation
      end

      @unique_count = @tiles.uniq.count
      @count = @tiles.count
    end

    def ==(other)
      @msp_notation == other.msp_notation
    end

    def <=>(other)
      @tiles.hash <=> other.tiles.hash
    end

    def inspect
      "#<#{self.class.name}:\"#{@msp_notation}\">"
    end

    def to_s
      @msp_notation
    end

    def pair?
      @unique_count == 1 && @count == 2
    end

    def triplet?
      @unique_count == 1 && @count == 3
    end

    def quad?
      @unique_count == 1 && @count == 4
    end

    def run?
      return false unless @tiles.map {|tile| tile[-1] }.uniq.count == 1

      chow_candidates = @tiles.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

      return false unless chow_candidates.uniq.count == 3

      [chow_candidates[0] + 2,  chow_candidates[1] + 1, chow_candidates[2]].uniq.count == 1
    end

    def revealed?
      @revealed ||= quad? || !!@msp_notation[/[#{Parser::MELDED_SYMBOLS}]/]
    end

    private

    def to_msp_notation
      @tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
    end
  end
end
