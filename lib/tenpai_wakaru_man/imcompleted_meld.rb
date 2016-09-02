module TenpaiWakaruMan
  class ImcompletedMeld
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

      # XXX hm...?
      return nil unless @tiles.count == 2

      @unique_count = @tiles.uniq.count
    end

    def inspect
      "#<ImcompletedMeld:\"#{@msp_notation}\">"
    end

    def to_s
      @msp_notation
    end

    def wanting_tile
      @wanting_tile =
        if triplet?
          [@tiles.first]
        elsif run?
          case run_waits_form
          when :penchan
            @tiles.first == "1m" ? [Tile.next(@tiles.last)] : [Tile.prev(@tiles.first)]
          when :kanchan
            [Tile.next(@tiles.first)]
          when :ryanmen
            [Tile.prev(@tiles.first), Tile.next(@tiles.last)]
          else
            raise('unknown form')
          end
        else
          nil
        end
    end

    def triplet?
      @unique_count == 1
    end

    def run?
      return false if triplet? || !only_one_suit?

      distance_of_tiles <= 2
    end

    def distance_of_tiles
      # penchan:  [1,2], kanchan:  [1,3], ryanmen: [2,3]
      @distance_of_tiles ||= (TILES[@tiles.first] - TILES[@tiles.last]).abs
    end

    def run_waits_form
      @run_waits_form ||=
        case distance_of_tiles
        when 1; include_terminal? ? :penchan : :ryanmen
        when 2; :kanchan
        else nil
        end
    end

    def include_terminal?
      /[19]/.match?(@msp_notation)
    end

    def only_one_suit?
      @tiles.map {|tile| tile[-1] }.uniq.count == 1
    end

    private

    def to_msp_notation
      @tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
    end
  end
end
