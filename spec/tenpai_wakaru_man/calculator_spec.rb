require 'spec_helper'

describe TenpaiWakaruMan::Calculator do
  describe '.calculate' do
    subject { TenpaiWakaruMan::Calculator.calculate(tiles) }

    context 'not ready' do
      let(:tiles) { '123m123s123456pPFd' }
      it { is_expected.to be_nil }
    end
  end
end
