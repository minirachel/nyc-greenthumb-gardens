require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface
    def initialize
        Scraper.gardens_api
        Scraper.garden_hashes
    end
    #switched make_gardens to initialize?

    def run
        puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
        puts "What are you interested in learning about today? Enter a number and I’ll give you more info :)" 
        # input = gets.strip
        index_card(random_garden)
    end


    def all_gardens_detail
        Garden.all.each {|g| g.index_card}
    end
    
    def random_garden
        Garden.all.sample
    end

    def index_card(garden)
        garden.tap do |g|
            puts "------------------------------------"
            puts " ~*~ #{g.gardenname} ~*~"
            puts "  ##{g.parksid}"
            puts "  #{Garden.translate_borough(g.borough)} - ZIP Code: #{g.zipcode}"
        end
    # puts " #{shape_print}"
    #value is nil due to puts
    #look at music CLI - NEEDS TO TAKE IN AN ARGUMENT?!
    #why tap not map
    end 




end