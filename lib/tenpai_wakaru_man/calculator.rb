module TenpaiWakaruMan
  class Calculator
    class << self
      def calculate(tiles)
        new.calculate(tiles)
      end
    end

    def initialize
    end

    def calculate(tiles)
      hand = Parser.parse(tiles)
      return nil unless hand.ready?
    end
  end
end
