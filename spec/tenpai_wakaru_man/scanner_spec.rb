require 'spec_helper'

describe TenpaiWakaruMan::Scanner do
  describe '.scan' do
    subject { TenpaiWakaruMan::Scanner.scan(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)) }
    end
  end
end
