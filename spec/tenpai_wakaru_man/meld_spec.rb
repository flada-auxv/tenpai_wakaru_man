require 'spec_helper'

describe TenpaiWakaruMan::Meld do
  describe '#initialize' do
    subject(:meld) { TenpaiWakaruMan::Meld.new(tiles) }

    context 'with string(msp_notation)' do
      let(:tiles) { '222pa' }

      it { expect(meld.tiles).to eq(%w(2p 2p 2p)) }
      it { expect(meld.msp_notation).to eq('222pa') }
    end

    context 'with array' do
      let(:tiles) { %w(2p 2p 2p) }

      it { expect(meld.tiles).to eq(%w(2p 2p 2p)) }
      it { expect(meld.msp_notation).to eq('222p') }
    end
  end

  describe '#triplet?' do
    subject { TenpaiWakaruMan::Meld.new(tiles).triplet? }

    context 'case1' do
      let(:tiles) { %w(1m 1m 1m) }
      it { is_expected.to be true }
    end

    context 'quad' do
      let(:tiles) { %w(1m 1m 1m 1m) }
      it { is_expected.to be false }
    end
  end

  describe '#quad?' do
    subject { TenpaiWakaruMan::Meld.new(tiles).quad? }

    context 'case1' do
      let(:tiles) { %w(1m 1m 1m 1m) }
      it { is_expected.to be true }
    end

    context 'triplet' do
      let(:tiles) { %w(1m 1m 1m) }
      it { is_expected.to be false }
    end
  end

  describe '#run?' do
    subject { TenpaiWakaruMan::Meld.new(tiles).run? }

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

  describe '#type' do
    subject { TenpaiWakaruMan::Meld.new(tiles).type }

    context 'pair' do
      let(:tiles) { "11m" }
      it { is_expected.to eq(:pair) }
    end

    context 'run' do
      let(:tiles) { "123m" }
      it { is_expected.to eq(:run) }
    end

    context 'open triplet' do
      let(:tiles) { "111ml" }
      it { is_expected.to eq(:open_triplet) }
    end

    context 'closed triplet' do
      let(:tiles) { "111m" }
      it { is_expected.to eq(:closed_triplet) }
    end

    context 'open quad' do
      let(:tiles) { "1111ma" }
      it { is_expected.to eq(:open_quad) }
    end

    context 'no role' do
      let(:tiles) { "135m" }
      it { is_expected.to eq(nil) }
    end
  end

  describe '#include_terminal_or_honor?' do
    subject { TenpaiWakaruMan::Meld.new(tiles).include_terminal_or_honor? }

    context 'with honor' do
      let(:tiles) { 'PPPd' }
      it { is_expected.to be true }
    end

    context 'with terminal' do
      let(:tiles) { '123m' }
      it { is_expected.to be true }
    end

    context 'without honor or terminal' do
      let(:tiles) { '234m' }
      it { is_expected.to be false }
    end
  end
end
