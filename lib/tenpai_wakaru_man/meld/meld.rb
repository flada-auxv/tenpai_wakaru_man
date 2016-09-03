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
      msp_notation <=> other.msp_notation
    end

    def inspect
      "#<Meld:\"#{@msp_notation}\">"
    end

    def to_s
      @msp_notation
    end

    def only_one_suit?
      @tiles.map {|tile| tile[-1] }.uniq.count == 1
    end

    def include_honor?
      /[#{Parser::HONOR_SYMBOLS}]/.match?(@msp_notation)
    end

    def include_terminal?
      /[19]/.match?(@msp_notation)
    end

    def include_terminal_or_honor?
      include_honor? || include_terminal?
    end

    def exclude_terminal_or_honor?
      !include_terminal_or_honor?
    end

    private

    def to_msp_notation
      @tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
    end
  end
end
