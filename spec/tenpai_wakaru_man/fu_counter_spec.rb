require 'spec_helper'

describe TenpaiWakaruMan::FuCounter do
  describe '.count' do
    let(:options) { {tsumo_or_ron: tsumo_or_ron, prevailing_wind: prevailing_wind, seat_wind: seat_wind, waits: waits} }
    let(:tsumo_or_ron) { :ron }
    let(:prevailing_wind) { "Ew" }
    let(:seat_wind) { "Sw" }
    let(:waits) { :ryanmen }

    subject { TenpaiWakaruMan::FuCounter.count(hand, options) }

    context 'case1' do
      let(:tsumo_or_ron) { :tsumo }
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m111s456pEEw').winning_hands[0] }
      it { is_expected.to eq(40) }
    end

    context 'chiitoitsu' do
      let(:tsumo_or_ron) { :tsumo }
      let(:hand) { TenpaiWakaruMan::Parser.parse('114477m225588p33s').winning_hands[0] }
      it { is_expected.to eq(25) }
    end

    context 'pinfu' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456p11m').winning_hands[0] }
      xit { is_expected.to eq(30) } # TODO pinfu
    end
  end

  describe '#count_by_win_kind' do
    subject { TenpaiWakaruMan::FuCounter.new(hand).count_by_win_kind(tsumo_or_ron) }

    context 'closed hand' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456p11m').winning_hands[0] }

      context 'tsumo' do
        let(:tsumo_or_ron) { :tsumo }
        it { is_expected.to eq(2) }
      end

      context 'ron' do
        let(:tsumo_or_ron) { :ron }
        it { is_expected.to eq(10) }
      end
    end

    context 'open hand' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123sl456p11m').winning_hands[0] }

      context 'tsumo' do
        let(:tsumo_or_ron) { :tsumo }
        it { is_expected.to eq(2) }
      end

      context 'ron' do
        let(:tsumo_or_ron) { :ron }
        it { is_expected.to eq(0) }
      end
    end
  end

  describe '#count_by_melds' do
    subject { TenpaiWakaruMan::FuCounter.new(hand).count_by_melds }

    context 'with open/closed triplet and quad' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('1111m2222ml333m444ma55m').winning_hands[0] }
      it { is_expected.to eq(46) }
    end

    context 'max case(probably..)' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('1111m9999m111pPPPdl55m').winning_hands[0] }
      it { is_expected.to eq(76) }
    end

    context 'only run' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456p11m').winning_hands[0] }
      it { is_expected.to eq(0) }
    end
  end

  describe '#count_by_head' do
    subject { TenpaiWakaruMan::FuCounter.new(hand).count_by_head(prevailing_wind: prevailing_wind, seat_wind: seat_wind) }

    context 'head is prevailing_wind and seat_wind' do
      let(:hand) { ; TenpaiWakaruMan::Parser.parse('123456m123s456pEEw').winning_hands[0] }
      let(:prevailing_wind) { "Ew" }
      let(:seat_wind) { "Ew" }
      it { is_expected.to eq(4) }
    end

    context 'other' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456pWWw').winning_hands[0] }
      let(:prevailing_wind) { "Ew" }
      let(:seat_wind) { "Sw" }
      it { is_expected.to eq(0) }
    end
  end

  describe '#count_by_waits' do
    subject { TenpaiWakaruMan::FuCounter.new(hand).count_by_waits(waits) }

    context 'waiting for one kind of tile' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456pEEw').winning_hands[0] }
      let(:waits) { :tanki }
      it { is_expected.to eq(2) }
    end

    context 'other' do
      let(:hand) { TenpaiWakaruMan::Parser.parse('123456m123s456pEEw').winning_hands[0] }
      let(:waits) { :ryanmen }
      it { is_expected.to eq(0) }
    end
  end
end
