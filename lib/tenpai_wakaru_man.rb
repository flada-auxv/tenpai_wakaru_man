require "tenpai_wakaru_man/version"
require "tenpai_wakaru_man/errors"
require "tenpai_wakaru_man/parser"
require "tenpai_wakaru_man/calculator"

require "tenpai_wakaru_man/imcompleted_meld"
require "core_ext/regexp"

module TenpaiWakaruMan
  class << self
    def win?(str)
      Parser.parse(str).win?
    end

    def ready?(str)
      Parser.parse(str).ready?
    end
  end
end
