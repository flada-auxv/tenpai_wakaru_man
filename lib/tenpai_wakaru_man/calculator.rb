require 'tenpai_wakaru_man/ten'

module TenpaiWakaruMan
  class Calculator
    class << self
      def calculate(tiles)
        new.calculate(tiles)
      end
    end

    def initialize
    end

    def calculate(tiles, options = {})
      hand = Parser.parse(tiles)
      return nil unless hand.ready?

      options[:tsumo_or_ron] = :ron

      fu = FuCounter.count(hand)
      han = HanCounter.count(hand)

      {fu: fu, han: han, ten: TEN[han.size][fu][options[:tsumo_or_ron].to_s]}
    end

    class HanCounter
      def self.count(hand)
        %i(pinfu)
      end
    end

    class FuCounter
      def self.count(hand)
        30
      end
    end
  end
end
