require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface

    #could switch make_gardens to initialize?

    def run
        make_gardens
        puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
        puts "What are you interested in learning about today? Enter a number and I’ll give you more info :)"
        puts Garden.filter_by_borough("R").index_card
    end

    def make_gardens
        Scraper.gardens_api
        Scraper.garden_hashes
    end
    
    def index_card
        puts "------------------------------------"
        puts " ~*~ #{@gardenname} ~*~"
        puts "  ##{@parksid}"
        puts "  #{translate_borough} - ZIP Code: #{@zipcode}"
        # puts " #{shape_print}"
        #value is nil due to puts
        #look at music CLI
    end
    



end