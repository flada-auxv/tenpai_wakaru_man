require "tenpai_wakaru_man/version"
require "tenpai_wakaru_man/set"
require "tenpai_wakaru_man/tiles"

module TenpaiWakaruMan
  class Detector
    class << self
      def ready?(str)
        new.ready?(str)
      end
    end

    def initialize
    end

    def ready?(tiles)
      Parser.parse(tiles).ready?
    end
  end
end
