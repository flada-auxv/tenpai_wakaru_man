require 'spec_helper'

describe TenpaiWakaruMan::Parser do
  describe '.scan' do
    subject { TenpaiWakaruMan::Parser.scan(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(%w(123m 222p 345s SSSw PPd)) }
    end

    context 'case2' do
      let(:tile_str) { '123ml222pa1111srSSSwPPd' }
      it { is_expected.to eq(%w(123ml 222pa 1111sr SSSw PPd)) }
    end
  end

  describe '.split' do
    subject { TenpaiWakaruMan::Parser.split(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)) }
    end

    context 'case2' do
      let(:tile_str) { '123ml222pa1111srSSSwPPd' }
      it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 1s 1s 1s 1s 2p 2p 2p)) }
    end
  end

  describe '.parse' do
    subject(:hand) { TenpaiWakaruMan::Parser.parse(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(TenpaiWakaruMan::Hand.new(tiles: %w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p))) }
    end

    context 'case2' do
      let(:tile_str) { '123ml222pa1111srSSSSwPPd' }

      it { expect(hand.tiles).to eq(%w(Pd Pd)) }
      it { expect(hand.sets).to eq([
        TenpaiWakaruMan::Set.new("123ml"), TenpaiWakaruMan::Set.new("222pa"), TenpaiWakaruMan::Set.new("1111sr"), TenpaiWakaruMan::Set.new("SSSSw")
      ]) }
    end
  end
end
