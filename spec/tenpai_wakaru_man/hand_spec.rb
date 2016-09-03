require 'spec_helper'

describe TenpaiWakaruMan::Hand do
  describe '#winning_hands' do
    subject(:hands) { TenpaiWakaruMan::Hand.parse_from(str).winning_hands }

    context 'case1' do
      let(:str) { "123m222p345sSSSwPPd" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "Pd",
          melds: [TenpaiWakaruMan::CompletedMeld.new("SSSw"), TenpaiWakaruMan::CompletedMeld.new("123m"), TenpaiWakaruMan::CompletedMeld.new("345s"), TenpaiWakaruMan::CompletedMeld.new("222p")]
        )
      )}
    end

    context 'case2' do
      let(:str) { "11122233445555m" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "2m",
          melds: [TenpaiWakaruMan::CompletedMeld.new("111m"), TenpaiWakaruMan::CompletedMeld.new("234m"), TenpaiWakaruMan::CompletedMeld.new("345m"), TenpaiWakaruMan::CompletedMeld.new("555m")]
        ),
        TenpaiWakaruMan::Hand.new(
          head: "5m",
          melds: [TenpaiWakaruMan::CompletedMeld.new("111m"), TenpaiWakaruMan::CompletedMeld.new("222m"), TenpaiWakaruMan::CompletedMeld.new("345m"), TenpaiWakaruMan::CompletedMeld.new("345m")]
        )
      )}
    end

    context 'case3' do
      let(:str) { "123ml222pa1111srSSSSwPPd" }

      xit '暗槓だということが明示的ではないのに CompletedMeld として扱ってるのはおかしい。そして暗槓を明示する記号はまだない。' do
        is_expected.to contain_exactly(
          TenpaiWakaruMan::Hand.new(
            head: "Pd",
            melds: [TenpaiWakaruMan::CompletedMeld.new("123ml"), TenpaiWakaruMan::CompletedMeld.new("222pa"), TenpaiWakaruMan::CompletedMeld.new("1111sr"), TenpaiWakaruMan::CompletedMeld.new("SSSSw")]
          )
        )
      end
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

  describe '#ready?' do
    subject { TenpaiWakaruMan::Hand.parse_from(str).ready? }

    context 'case1' do
      let(:str) { "EEw123456m123s45p" }
      it { is_expected.to be true }
    end

    context 'case2' do
      let(:str) { "EEw123456m123s46p" }
      it { is_expected.to be true }
    end

    context 'case3' do
      let(:str) { "EEw123456m123s47p" }
      it { is_expected.to be false }
    end

    context 'case4' do
      let(:str) { "EEw123456m123s44p" }
      it { is_expected.to be true }
    end

    context 'case5' do
      let(:str) { "1112223344555m" }
      it { is_expected.to be true }
    end

    context 'seven_pairs' do
      let(:str) { "EEw112233m11s556p" }
      it { is_expected.to be true }
    end

    context 'thirteen_orphans' do
      let(:str) { "19m19s19pESWNwPFCd" }
      it { is_expected.to be true }
    end
  end
end
