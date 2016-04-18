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
end
