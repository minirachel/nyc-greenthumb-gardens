require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface

    def run
        make_gardens
        Garden.print_gardens
    end

    def make_gardens
        Scraper.gardens_api
        Scraper.garden_hashes
    end
end