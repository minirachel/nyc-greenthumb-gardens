require 'bundler/setup'
Bundler.require
#requires all gems in gem file

require_relative '../lib/scraper.rb'
require_relative '../lib/garden.rb'
require_relative '../lib/command_line_interface.rb'
require_relative '../lib/version.rb'
# require_relative '../bin/run.rb'