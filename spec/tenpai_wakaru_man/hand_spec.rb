require 'spec_helper'

describe TenpaiWakaruMan::Hand do
  describe '#ready_hands' do
    subject(:hands) { TenpaiWakaruMan::Hand.parse_from(str).ready_hands }

    context 'case1' do
      let(:str) { "123m222p345sSSSwPPd" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "Pd",
          melds: [TenpaiWakaruMan::Meld.new("SSSw"), TenpaiWakaruMan::Meld.new("123m"), TenpaiWakaruMan::Meld.new("345s"), TenpaiWakaruMan::Meld.new("222p")]
        )
      )}
    end

    context 'case2' do
      let(:str) { "11122233445555m" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "2m",
          melds: [TenpaiWakaruMan::Meld.new("111m"), TenpaiWakaruMan::Meld.new("234m"), TenpaiWakaruMan::Meld.new("345m"), TenpaiWakaruMan::Meld.new("555m")]
        ),
        TenpaiWakaruMan::Hand.new(
          head: "5m",
          melds: [TenpaiWakaruMan::Meld.new("111m"), TenpaiWakaruMan::Meld.new("222m"), TenpaiWakaruMan::Meld.new("345m"), TenpaiWakaruMan::Meld.new("345m")]
        )
      )}
    end

    context 'case3' do
      let(:str) { "123ml222pa1111srSSSSwPPd" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "Pd",
          melds: [TenpaiWakaruMan::Meld.new("123ml"), TenpaiWakaruMan::Meld.new("222pa"), TenpaiWakaruMan::Meld.new("1111sr"), TenpaiWakaruMan::Meld.new("SSSSw")]
        )
      )}
    end
  end

  describe '#thirteen_orphans?' do
    subject(:hands) { TenpaiWakaruMan::Hand.parse_from(str).thirteen_orphans? }

    context '13 kinds, but is not only terminal and honor' do
      let(:str) { "EEw123456m123s456p" }
      it { is_expected.to be false }
    end

    context 'only terminal or honor' do
      let(:str) { "119m19s19pESWNwPFCd" }
      it { is_expected.to be true }
    end
  end
end
