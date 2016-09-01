require 'spec_helper'

describe TenpaiWakaruMan do
  describe '.win?' do
    subject { TenpaiWakaruMan.win?(str) }

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
      it { is_expected.to be true }
    end

    context 'Seven Pairs' do
      let(:str) { "112233m11p22sEEwPPd" }
      it { is_expected.to be true }
    end
  end
end
