require 'tenpai_wakaru_man/hand'
require 'tenpai_wakaru_man/meld'

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
        args = scan(tile_str).map {|tiles| Meld.new(tiles) }.chunk {|meld| meld.melded? || meld.kong? }.each_with_object({melds: [], tiles: []}) {|(bool, value), hash|
          bool ? hash[:melds] += value : hash[:tiles] += value.map(&:tiles).flatten
        }

        Hand.build(args)
      end
    end
  end
end
