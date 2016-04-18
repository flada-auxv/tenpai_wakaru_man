require "tenpai_wakaru_man/version"

module TenpaiWakaruMan
  class Detector
    attr_accessor :tiles

    class << self
      def tenpai?(str)
        new(str).tenpai?
      end
    end

    def initialize(tiles)
      @tiles = tiles
      parse!
    end

    def tenpai?
      true
    end

    def head_candidates
      ['22', 'SS', 'PP']
    end

    def parse!
      @tiles = @tiles.scan(/\d+[mps]|[ESWN]+w?|[PFC]+d?/).map {|str|
        str.chop.chars.map {|s| s + str[-1] }
      }.flatten
    end
  end
end
