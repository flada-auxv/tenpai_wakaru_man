require 'spec_helper'

describe TenpaiWakaruMan::ImcompletedMeld do
  describe '#triplet?' do
    subject { TenpaiWakaruMan::ImcompletedMeld.new(str).triplet? }

    context 'case1' do
      let(:str) { '11m' }
      it { is_expected.to be true }
    end

    context 'case2' do
      let(:str) { '12m' }
      it { is_expected.to be false }
    end
  end

  describe '#run?' do
    subject { TenpaiWakaruMan::ImcompletedMeld.new(str).run? }

    context 'case1' do
      let(:str) { '12m' }
      it { is_expected.to be true }
    end

    context 'case2' do
      let(:str) { '13m' }
      it { is_expected.to be true }
    end

    context 'case3' do
      let(:str) { '23m' }
      it { is_expected.to be true }
    end

    context 'case4' do
      let(:str) { '1m2p' }
      it { is_expected.to be false }
    end

    context 'case5' do
      let(:str) { '11m' }
      it { is_expected.to be false }
    end
  end

  describe '#wanting_tile' do
    subject { TenpaiWakaruMan::ImcompletedMeld.new(str).wanting_tile }

    context 'penchan' do
      let(:str) { '89m' }
      it { is_expected.to eq(['7m']) }
    end

    context 'kanchan' do
      let(:str) { '35m' }
      it { is_expected.to eq(['4m']) }
    end

    context 'ryanmen' do
      let(:str) { '34m' }
      it { is_expected.to eq(['2m', '5m']) }
    end

    context 'triplet' do
      let(:str) { '11m' }
      it { is_expected.to eq(['1m']) }
    end
  end
end
