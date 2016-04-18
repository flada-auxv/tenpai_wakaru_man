require 'spec_helper'

describe TenpaiWakaruMan::Detector do
  describe '.tenpai?' do
    subject { TenpaiWakaruMan::Detector.tenpai?(str) }

    context '省略無し' do
      let(:str) { "123m222p345sSSSwPPd" }

      it { is_expected.to be true }
    end

    context '省略あり' do
      let(:str) { "123m222p345sSSSPP" }

      it { is_expected.to be true }
    end
  end

  describe '#head_candidates' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.new(str).head_candidates }

    it { is_expected.to contain_exactly('22', 'SS', 'PP') }
  end

  describe '#parse' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.new(str).parse }

    it { is_expected.to match_array(%w(1m 2m 3m 2p 2p 2p 3s 4s 5s Sw Sw Sw Pd Pd)) }
  end
end
