require 'tenpai_wakaru_man/hand'

module TenpaiWakaruMan
  class Scanner
    REGEXP = /((\d+[mps]?|[ESWN]+w?|[PFC]+d)[LAR]?)/

    class << self
      def scan(tile_str)
        tile_str.scan(REGEXP).map {|match| match.first }
      end

      def split(tile_str)
        scan(tile_str).map {|tile|
          tile.delete("mspdwLAR").chars.map {|str| str + tile[/[mspdw]/] }
        }.flatten.sort_by {|tile| TILES[tile] }
      end

      def parse(tile_str)
        scan(tile_str).each_with_object(Hand.new) {|tile, hand|
          if tile[/[LAR]/]
            hand << Set.new(tile)
          else
            hand << tile.delete("mspdwLAR").chars.map {|str| str + tile[/[mspdw]/] }
          end
        }
      end

      def join_tiles(tiles)
        tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
      end
    end
  end
end
