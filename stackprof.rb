# bundle exec ruby stackprof.rb
# bundle exec stackprof tmp/stackprof-cpu-myapp.dump --text --limit 5

require 'stackprof'
require 'tenpai_wakaru_man'

StackProf.run(mode: :cpu, out: 'tmp/stackprof-cpu-myapp.dump') do
  TenpaiWakaruMan::Detector.win?("11122233445555m")
end
