require 'benchmark/ips'
require 'tenpai_wakaru_man'

Benchmark.ips do |x|
  x.config(:time => 10, :warmup => 2)

  x.report {
    TenpaiWakaruMan::Hand.parse_from("11122233445555m").meld_combination()
  }
end
