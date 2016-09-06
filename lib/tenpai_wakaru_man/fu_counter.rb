module TenpaiWakaruMan
  class FuCounter
    HUTEI = 20
    MENZEN_KAFU = 10
    MELDS = {
      pair: 0,
      run: 0,
      open_triplet: 2,
      closed_triplet: 4,
      open_quad: 8,
      closed_quad: 16
    }

    class << self
      def count(hand, options = {})
        new(hand).count(options)
      end
    end

    def initialize(hand)
      @hand = hand
    end

    # tsumo_or_ron: [:tsumo, :ron]
    # prevailing_wind: ["Ew", "Sw", "Ww", "Nw"]
    # seat_wind: ["Ew", "Sw", "Ww", "Nw"]
    # waits: [:ryanmen, :kanchan, :penchan, :tanki, :shanpon]
    def count(options = {})
      return 25 if @hand.seven_pairs?
      return 30 if @hand.thirteen_orphans? # XXX ほんと？

      fu = HUTEI +
          count_by_win_kind(options[:tsumo_or_ron]) +
          count_by_melds +
          count_by_head(prevailing_wind: options[:prevailing_wind], seat_wind: options[:seat_wind]) +
          count_by_waits(options[:waits])

      (fu / 10.0).ceil * 10
    end

    def count_by_win_kind(tsumo_or_ron)
      fu = 0
      fu += MENZEN_KAFU if tsumo_or_ron == :ron && @hand.closed?
      fu += 2 if tsumo_or_ron == :tsumo
      fu
    end

    def count_by_melds
      @hand.melds.map {|meld|
        fu = MELDS[meld.type]
        fu *= 2 if meld.include_terminal_or_honor?
        fu
      }.inject(&:+)
    end

    def count_by_head(prevailing_wind:, seat_wind:)
      fu = 0
      fu += 2 if @hand.head == prevailing_wind
      fu += 2 if @hand.head == seat_wind
      fu
    end

    def count_by_waits(waits)
      %i(kanchan penchan tanki).include?(waits) ? 2 : 0
    end
  end
end
