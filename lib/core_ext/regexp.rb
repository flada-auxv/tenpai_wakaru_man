# for RUBY_VERSION < 2.4.0
class Regexp
  def match?(string, pos = 0)
    !!match(string, pos)
  end unless //.respond_to?(:match?)
end
