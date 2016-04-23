require 'spec_helper'

describe TenpaiWakaruMan::Set do
  describe '#pong?' do
    subject { TenpaiWakaruMan::Set.new(tiles).pong? }

    context 'case1' do
      let(:tiles) { %w(1m 1m 1m) }
      it { is_expected.to be true }
    end

    context 'kong' do
      let(:tiles) { %w(1m 1m 1m 1m) }
      it { is_expected.to be false }
    end
  end

  describe '#kong?' do
    subject { TenpaiWakaruMan::Set.new(tiles).kong? }

    context 'case1' do
      let(:tiles) { %w(1m 1m 1m 1m) }
      it { is_expected.to be true }
    end

    context 'pong' do
      let(:tiles) { %w(1m 1m 1m) }
      it { is_expected.to be false }
    end
  end

  describe '#chow?' do
    subject { TenpaiWakaruMan::Set.new(tiles).chow? }

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

  describe '#melded_type' do
    subject { TenpaiWakaruMan::Set.new(tiles).melded_type }

    context 'not melded' do
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
