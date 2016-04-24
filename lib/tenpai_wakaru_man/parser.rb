require 'tenpai_wakaru_man/hand'
require 'tenpai_wakaru_man/meld'

module TenpaiWakaruMan
  class Parser
    SUITED_SYMBOLS = "msp"
    DRAGON_SYMBOL = "d"
    WIND_SYMBOL = "w"
    OPEN_MELDED_SYMBOLS = "lar"
    HONOR_SYMBOLS = DRAGON_SYMBOL + WIND_SYMBOL
    MELD_SYMBOLS = SUITED_SYMBOLS + HONOR_SYMBOLS + OPEN_MELDED_SYMBOLS

    MELD_REGEXP = /((\d+[#{SUITED_SYMBOLS}]|[PFC]+#{DRAGON_SYMBOL}|[ESWN]+#{WIND_SYMBOL})[#{OPEN_MELDED_SYMBOLS}]?)/

    class << self
      def scan(tile_str)
        tile_str.scan(MELD_REGEXP).map {|tile_with_suite, _| tile_with_suite }
      end

      def split(tile_str)
        scan(tile_str).map {|tile|
          meld_type = tile[/[#{MELD_SYMBOLS}]/]
          tile.delete(MELD_SYMBOLS).chars.map {|str| str + meld_type }
        }.flatten.sort_by {|tile| TILES[tile] }
      end

      def parse(tile_str)
        args = scan(tile_str).map {|tiles| Meld.new(tiles) }.chunk {|meld| meld.revealed? }.each_with_object({melds: [], tiles: []}) {|(bool, value), hash|
          bool ? hash[:melds] += value : hash[:tiles] += value.map(&:tiles).flatten
        }

        Hand.build(args)
      end
    end
  end
end
