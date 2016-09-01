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

      @unique_count = @tiles.uniq.count
      @count = @tiles.count
    end

    def inspect
      "#<ImcompletedMeld:\"#{@msp_notation}\">"
    end

    def to_s
      @msp_notation
    end

    def wanting_tile

    end

    def pair?;    @unique_count == 1 && @count == 2 end


    private

    def to_msp_notation
      @tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
    end
  end
end
