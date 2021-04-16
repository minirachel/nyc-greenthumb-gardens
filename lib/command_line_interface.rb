require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface

    #could switch make_gardens to initialize?

    def run
        make_gardens
        puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
        puts "What are you interested in learning about today? Enter a number and I’ll give you more info :)"
        puts Garden.gardens_by_borough("R")
    end

    def make_gardens
        Scraper.gardens_api
        Scraper.garden_hashes
    end

    



end