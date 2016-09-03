module TenpaiWakaruMan
  TILES = {
    "Ew" => 0,  "Sw" => 1,  "Ww" => 2,  "Nw" => 3,
    "Cd" => 4,  "Fd" => 5,  "Pd" => 6,
    "1m" => 7,  "2m" => 8,  "3m" => 9,  "4m" => 10, "5m" => 11, "6m" => 12, "7m" => 13, "8m" => 14, "9m" => 15,
    "1s" => 16, "2s" => 17, "3s" => 18, "4s" => 19, "5s" => 20, "6s" => 21, "7s" => 22, "8s" => 23, "9s" => 24,
    "1p" => 25, "2p" => 26, "3p" => 27, "4p" => 28, "5p" => 29, "6p" => 30, "7p" => 31, "8p" => 32, "9p" => 33
  }.freeze

  module Tile
    class << self
      def next(tile)
        TILES.key(TILES[tile] + 1)
      end

      def prev(tile)
        TILES.key(TILES[tile] - 1)
      end
    end
  end
end
