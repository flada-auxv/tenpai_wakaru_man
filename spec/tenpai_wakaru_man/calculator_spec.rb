require 'spec_helper'

describe TenpaiWakaruMan::Calculator do
  describe '.calculate' do
    subject { TenpaiWakaruMan::Calculator.calculate(tiles) }

    context 'not ready' do
      let(:tiles) { '123m123s123456pPFd' }
      it { is_expected.to be_nil }
    end

    context 'pinfu' do
      let(:tiles) { '123456m456s78999p' }
      xit { is_expected.to eq({fu: 30, han: [:pinfu], ten: 1000}) }
    end
  end
end
