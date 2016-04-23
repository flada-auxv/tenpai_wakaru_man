require 'tenpai_wakaru_man/hand'

module TenpaiWakaruMan
  class Parser
    SET_REGEXP = /((\d+[msp]|[PFC]+d|[ESWN]+w)[lar]?)/
    SUIT_SYMBOLS = "mspdw"
    MELDED_SYMBOLS = "lar"

    class << self
      def scan(tile_str)
        tile_str.scan(SET_REGEXP).map {|tile_with_suite, _| tile_with_suite }
      end

      def split(tile_str)
        scan(tile_str).map {|tile|
          suit = tile[/[#{SUIT_SYMBOLS}]/]
          tile.delete(SUIT_SYMBOLS + MELDED_SYMBOLS).chars.map {|str| str + suit }
        }.flatten.sort_by {|tile| TILES[tile] }
      end

      def parse(tile_str)
        scan(tile_str).each_with_object(Hand.new) {|tile, hand|
          if tile[/[#{MELDED_SYMBOLS}]/] # melded pong, melded kong, melded chow
            hand << Set.new(tile)
          elsif (set = Set.new(tile)).kong? # concealed kong
            hand << set
          else
            suit = tile[/[#{SUIT_SYMBOLS}]/]
            hand << tile.delete(SUIT_SYMBOLS + MELDED_SYMBOLS).chars.map {|str| str + suit }
          end
        }
      end

      def join_tiles(tiles)
        tiles.sort_by {|tile| TILES[tile] }.map {|tile| tile.split("") }.chunk {|_, suite| suite }.map {|key, arr| arr.map(&:first).join << key }.join
      end
    end
  end
end
