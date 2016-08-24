module TenpaiWakaruMan
  module Combination
    def combination(array, num)
      return [[]] if num == 0
      return array.map {|elem| Array(elem) } if num == 1

      enumerator =
        each_with_rest(array).with_object([]) {|(elem, rest), result|
          result.push(*_combination(rest, Array(elem), num))
        }.each

      block_given? ? enumerator.each {|elem| yield elem } : enumerator
    end

    private

    def each_with_rest(array)
      if block_given?
        array.each_with_index {|elem, i| yield elem, array[i+1..-1] }
      else
        array.map.with_index {|elem, i| [elem, array[i+1..-1]] }.each
      end
    end

    def _combination(array, candidates, num, result = [])
      each_with_rest(array).with_object(result) {|(elem, rest), result|
        _candidates = candidates.dup << elem

        if _candidates.count == num
          result << _candidates
        else
          _combination(rest, _candidates, num, result)
        end
      }
    end
  end
end
