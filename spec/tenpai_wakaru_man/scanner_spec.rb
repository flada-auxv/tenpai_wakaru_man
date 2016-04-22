require 'spec_helper'

describe TenpaiWakaruMan::Scanner do
  describe '.scan' do
    subject { TenpaiWakaruMan::Scanner.scan(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)) }
    end
  end

  describe '.parse' do
    subject(:hand) { TenpaiWakaruMan::Scanner.parse(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(TenpaiWakaruMan::Hand.new(tiles: %w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p))) }
    end

    context 'case2' do
      let(:tile_str) { '123mL222pA1111sRSSSwPPd' }

      it { expect(hand.tiles).to eq(%w(Sw Sw Sw Pd Pd)) }
      it { expect(hand.sets).to eq([
        TenpaiWakaruMan::Set.new("123mL"), TenpaiWakaruMan::Set.new("222pA"), TenpaiWakaruMan::Set.new("1111sR")
      ]) }
    end
  end
end
