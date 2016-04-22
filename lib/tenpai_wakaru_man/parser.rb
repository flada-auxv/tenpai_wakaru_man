module TenpaiWakaruMan
  class Parser
    REGEXP = /\d+[mps][LAR]?|[ESWN]+w?[LAR]?|[PFC]+d[LAR]?/

    class << self
      def parse_tile_str(tile_str)
        tile_str.scan(REGEXP).map {|str|
          str.chop.chars.map {|s| s + str[-1] }
        }.flatten.sort_by {|tile| TILES[tile] }
      end

      def join_tiles(tiles)
        tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
      end
    end
  end
end
