require 'tenpai_wakaru_man/ten'
require 'tenpai_wakaru_man/fu_counter'

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
      return nil if (hands = Parser.parse(tiles).ready_hands).empty?

      hands.map {|hand|
        options[:tsumo_or_ron] = :ron

        fu = FuCounter.count(hand)
        han = HanCounter.count(hand)

        {fu: fu, han: han, ten: TEN[han.size][fu][options[:tsumo_or_ron].to_s]}
      }.max {|hash| hash[:ten] }
    end

    class HanCounter
      def self.count(hand)
        %i(pinfu)
      end
    end
  end
end
