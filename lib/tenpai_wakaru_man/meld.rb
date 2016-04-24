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

    def open?; !!@msp_notation[/[#{Parser::OPEN_MELDED_SYMBOLS}]/] end
    def closed?; !open? end
    def revealed?; @revealed ||= open? || closed_quad? end

    def pair?;    @unique_count == 1 && @count == 2 end
    def triplet?; @unique_count == 1 && @count == 3 end
    def quad?;    @unique_count == 1 && @count == 4 end
    def run?
      return false unless @tiles.map {|tile| tile[-1] }.uniq.count == 1

      chow_candidates = @tiles.map {|tile| TILES[tile] }.select {|tile| tile > 6 }

      return false unless chow_candidates.uniq.count == 3

      [chow_candidates[0] + 2,  chow_candidates[1] + 1, chow_candidates[2]].uniq.count == 1
    end

    def open_triplet?;   open?   && triplet? end
    def closed_triplet?; closed? && triplet? end
    def open_quad?;      open?   && quad? end
    def closed_quad?;    closed? && quad? end

    def type
      case
      when pair?;           :pair
      when run?;            :run
      when open_triplet?;   :open_triplet
      when closed_triplet?; :closed_triplet
      when open_quad?;      :open_quad
      when closed_quad?;    :closed_quad
      end
    end

    private

    def to_msp_notation
      @tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
    end
  end
end
