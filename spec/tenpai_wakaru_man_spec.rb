require 'spec_helper'

describe TenpaiWakaruMan::Detector do
  describe '.tenpai?' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.tenpai?(str) }

    it { is_expected.to be true }
  end

  describe '.sequence?' do
    subject { TenpaiWakaruMan::Detector.sequence?(tiles) }

    context 'case1' do
      let(:tiles) { %w(1m 2m 3m) }
      it { is_expected.to be true }
    end

    context 'case2' do
      let(:tiles) { %w(Pd 1m 2m) }
      it { is_expected.to be false }
    end

    context 'case3' do
      let(:tiles) { %w(8m 9m 1s) }
      it { is_expected.to be false }
    end

    context 'case4' do
      let(:tiles) { %w(1m 2s 3m) }
      it { is_expected.to be false }
    end
  end

  describe '.triplet?' do
    let(:tiles) { %w(1m 1m 1m) }

    subject { TenpaiWakaruMan::Detector.triplet?(tiles) }

    it { is_expected.to be true }
  end

  describe '#initialize' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.new(str).tiles }

    it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)) }
  end

  describe '#head_candidates' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.new(str).head_candidates }

    it { is_expected.to contain_exactly('2p', 'Sw', 'Pd') }
  end

  describe '#hand_candidates' do
    let(:str) { "123m222p345sSSSwPPd" }

    subject { TenpaiWakaruMan::Detector.new(str).hand_candidates }

    it { is_expected.to contain_exactly(
      ['2p', %w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p)],
      ['Sw', %w(Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)],
      ['Pd', %w(Sw Sw Sw 1m 2m 3m 3s 4s 5s 2p 2p 2p)]
    ) }
  end
end
