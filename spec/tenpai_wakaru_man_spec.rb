require 'spec_helper'

describe TenpaiWakaruMan::Detector do
  describe '.tenpai?' do
    subject { TenpaiWakaruMan::Detector.tenpai?(str) }

    context 'case1' do
      let(:str) { "123m222p345sSSSwPPd" }
      it { is_expected.to be true }
    end

    context 'case2' do
      let(:str) { "11122233445555m" }
      it { is_expected.to be true }
    end

    context 'Nine Gates' do
      let(:str) { "11123455678999m" }
      it { is_expected.to be true }
    end

    context 'Four concealed Triples' do
      let(:str) { "EEESSSWWWNNNwPPd" }
      it { is_expected.to be true }
    end

    context 'Thirteen Orphans' do
      let(:str) { "119m19p19sESWNwPFCd" }
      xit { is_expected.to be true } # TODO
    end

    context 'Seven Pairs' do
      let(:str) { "112233m11p22sEEwPPd" }
      xit { is_expected.to be true } # TODO
    end
  end

  describe '.chow?' do
    subject { TenpaiWakaruMan::Detector.chow?(tiles) }

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

  describe '.pong?' do
    let(:tiles) { %w(1m 1m 1m) }

    subject { TenpaiWakaruMan::Detector.pong?(tiles) }

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
    )}
  end

  describe '#detect' do
    subject { TenpaiWakaruMan::Detector.new(str).detect }

    context 'case1' do
      let(:str) { "123m222p345sSSSwPPd" }
      it { is_expected.to contain_exactly(['Pd', %w(Sw Sw Sw 1m 2m 3m 3s 4s 5s 2p 2p 2p)]) }
    end

    context 'case2' do
      let(:str) { "11122233344555m" }
      it { is_expected.to contain_exactly(
        ['1m', %w(1m 2m 2m 2m 3m 3m 3m 4m 4m 5m 5m 5m)],
        ['4m', %w(1m 1m 1m 2m 2m 2m 3m 3m 3m 5m 5m 5m)]
      ) }
    end

    context 'Nine Gates' do
      let(:str) { "11123455678999m" }
      it { is_expected.to contain_exactly(['5m', %w(1m 1m 1m 2m 3m 4m 6m 7m 8m 9m 9m 9m)]) }
    end
  end
end
