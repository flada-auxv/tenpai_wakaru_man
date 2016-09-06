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
      return nil if (hands = Parser.parse(tiles).winning_hands).empty?

      hands.map {|hand|
        options[:tsumo_or_ron] = :ron

        fu = FuCounter.count(hand)
        yaku = YakuCounter.count(hand)
        han = yaku.values.inject(&:+)

        {fu: fu, han: yaku, ten: TEN[han][fu][options[:tsumo_or_ron].to_s]}
      }.max {|hash| hash[:ten] }
    end
  end

  class YakuCounter
    attr_accessor :hand, :result

    def initialize(hand )
      @hand = hand
      @result = {}
    end

    def self.count(hand)
      new(hand).count
    end

    def count
      chiitoitsu?

      result
    end

    def chiitoitsu?
      @result[:chiitoitsu] = 2 if hand.seven_pairs?
    end
  end
end
