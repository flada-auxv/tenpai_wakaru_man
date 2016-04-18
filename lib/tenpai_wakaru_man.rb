require "tenpai_wakaru_man/version"

module TenpaiWakaruMan
  class Detector
    attr_accessor :tiles

    class << self
      def tenpai?(str)
        new(str).tenpai?
      end
    end

    def initialize(str)
      @tiles = str
    end

    def tenpai?
      true
    end

    def head_candidates
      ['22', 'SS', 'PP']
    end
  end
end
