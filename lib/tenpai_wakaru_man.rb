require "tenpai_wakaru_man/version"
require "tenpai_wakaru_man/errors"
require "tenpai_wakaru_man/parser"
require "tenpai_wakaru_man/calculator"

module TenpaiWakaruMan
  class Detector
    class << self
      def winning?(str)
        new.winning?(str)
      end

      def ready?(str)
        new.ready?(str)
      end
    end

    def initialize
    end

    def winning?(tiles)
      Parser.parse(tiles).winning?
    end

    def ready?(tiles)
      Parser.parse(tiles).ready?
    end
  end
end
