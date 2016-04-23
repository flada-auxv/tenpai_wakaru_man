require "tenpai_wakaru_man/version"
require "tenpai_wakaru_man/set"
require "tenpai_wakaru_man/tiles"

module TenpaiWakaruMan
  class Detector
    attr_accessor :tiles, :hand

    class << self
      def ready?(str)
        new(str).ready?
      end
    end

    def initialize(tiles)
      @hand = Parser.parse(tiles)
    end

    def ready?
      @hand.ready?
    end
  end
end
