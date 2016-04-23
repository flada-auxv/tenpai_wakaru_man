require 'spec_helper'

describe TenpaiWakaruMan::Hand do
  describe '#ready_hands' do
    subject(:hands) { TenpaiWakaruMan::Hand.build(str).ready_hands }

    context 'case1' do
      let(:str) { "123m222p345sSSSwPPd" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "Pd",
          sets: [TenpaiWakaruMan::Set.new("SSSw"), TenpaiWakaruMan::Set.new("123m"), TenpaiWakaruMan::Set.new("345s"), TenpaiWakaruMan::Set.new("222p")]
        )
      )}
    end

    context 'case2' do
      let(:str) { "11122233445555m" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "2m",
          sets: [TenpaiWakaruMan::Set.new("111m"), TenpaiWakaruMan::Set.new("234m"), TenpaiWakaruMan::Set.new("345m"), TenpaiWakaruMan::Set.new("555m")]
        ),
        TenpaiWakaruMan::Hand.new(
          head: "5m",
          sets: [TenpaiWakaruMan::Set.new("111m"), TenpaiWakaruMan::Set.new("222m"), TenpaiWakaruMan::Set.new("345m"), TenpaiWakaruMan::Set.new("345m")]
        )
      )}
    end

    context 'case3' do
      let(:str) { "123ml222pa1111srSSSSwPPd" }

      it { is_expected.to contain_exactly(
        TenpaiWakaruMan::Hand.new(
          head: "Pd",
          sets: [TenpaiWakaruMan::Set.new("123ml"), TenpaiWakaruMan::Set.new("222pa"), TenpaiWakaruMan::Set.new("1111sr"), TenpaiWakaruMan::Set.new("SSSSw")]
        )
      )}
    end
  end
end
