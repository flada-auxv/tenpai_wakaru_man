require 'yaml'

module TenpaiWakaruMan
  TEN = YAML.load_file(File.expand_path('../ten.yml', __FILE__))
end
