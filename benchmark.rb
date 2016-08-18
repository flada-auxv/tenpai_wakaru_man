require 'benchmark/ips'
require 'tenpai_wakaru_man'

Benchmark.ips do |x|
  x.config(:time => 5, :warmup => 2)

  x.report {
    TenpaiWakaruMan::Detector.winning?("11122233445555m")
  }
end
