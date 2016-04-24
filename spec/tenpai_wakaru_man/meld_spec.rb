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

  describe '#revealed_type' do
    subject { TenpaiWakaruMan::Meld.new(tiles).revealed_type }

    context 'not revealed' do
      let(:tiles) { "123m" }
      xit { is_expected.to be_nil }
    end

    context 'chow' do
      let(:tiles) { "123ml" }
      xit { is_expected.to eq(:chow) }
    end

    context 'pong' do
      let(:tiles) { "111ml" }
      xit { is_expected.to eq(:pong) }
    end
  end
end
