require 'spec_helper'

describe TenpaiWakaruMan::Parser do
  describe '.parse_tile_str' do
    subject { TenpaiWakaruMan::Parser.parse_tile_str(tile_str) }

    context 'case1' do
      let(:tile_str) { '123m222p345sSSSwPPd' }
      it { is_expected.to eq(%w(Sw Sw Sw Pd Pd 1m 2m 3m 3s 4s 5s 2p 2p 2p)) }
    end
  end
end
