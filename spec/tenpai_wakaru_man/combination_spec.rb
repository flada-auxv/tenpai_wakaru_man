require 'spec_helper'

describe TenpaiWakaruMan::Combination do
  include TenpaiWakaruMan::Combination

  describe "#combination" do # from https://github.com/ruby/spec/blob/master/core/array/combination_spec.rb
    before :each do
      @array = [1, 2, 3, 4]
    end

    it "returns an enumerator when no block is provided" do
      expect(combination(@array, 2)).to be_an_instance_of(Enumerator)
    end

    it "returns self when a block is given" do
      expect(combination(@array, 2){}).to equal(@array)
    end

    it "yields nothing for out of bounds length and return self" do
      expect(combination(@array, 5).to_a).to eq []
      expect(combination(@array, -1).to_a).to eq []
    end

    it "yields the expected combinations" do
      expect(combination(@array, 3).to_a.sort).to eq [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
    end

    it "yields nothing if the argument is out of bounds" do
      expect(combination(@array, -1).to_a).to eq []
      expect(combination(@array, 5).to_a).to eq []
    end

    it "yields a copy of self if the argument is the size of the receiver" do
      r = combination(@array, 4).to_a
      expect(r).to eq [@array]
      expect(r[0]).to_not equal(@array)
    end

    it "yields [] when length is 0" do
      expect(combination(@array, 0).to_a).to eq [[]] # one combination of length 0
      expect(combination([], 0).to_a).to eq [[]] # one combination of length 0
    end

    it "yields a partition consisting of only singletons" do
      expect(combination(@array, 1).to_a.sort).to eq [[1],[2],[3],[4]]
    end

    it "generates from a defensive copy, ignoring mutations" do
      accum = []
      combination(@array, 2) do |x|
        accum << x
        @array[0] = 1
      end
      expect(accum).to eq [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
    end

    describe "when no block is given" do
      describe "returned Enumerator" do
        describe "size" do
          it "returns 0 when the number of combinations is < 0" do
            expect(combination(@array, -1).size).to eq 0
            expect(combination([], -2).size).to eq 0
          end
          it "returns the binomial coeficient between the array size the number of combinations" do
            expect(combination(@array, 5).size).to eq 0
            expect(combination(@array, 4).size).to eq 1
            expect(combination(@array, 3).size).to eq 4
            expect(combination(@array, 2).size).to eq 6
            expect(combination(@array, 1).size).to eq 4
            expect(combination(@array, 0).size).to eq 1
            expect(combination([], 0).size).to eq 1
            expect(combination([], 1).size).to eq 0
          end
        end
      end
    end
  end
end
