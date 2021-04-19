require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface
    def initialize
        Scraper.gardens_api
        Scraper.garden_hashes
    end
    #switched make_gardens to initialize?

    def run
        input = ""

        while input != "9"
            puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
            puts "What are you interested in learning about today? [enter a number]"
            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
            puts "[1] How many active gardens are there?"
            puts "[2] Show me a list of all gardens in the city, please."
            puts "[3] I'd like to see a random garden. Now."
            puts "[9] Let me leave."
        input = gets.strip
#print indent or repeat question
            case input
                when "1"
                    puts "Great question! How would you like me to pull the report?"
                    puts "[1] in all of New York City"
                    puts "[2] in my borough"
                    puts "[3] in my ZIP"
                    input = gets.strip
                    #use regex to strip brackets
                        case input
                            when "1"
                                 ALL OF NEW York
                            when "2"
                                puts "Ok! Which borough are you in?"
                                puts "[X] Bronx"
                                puts "[Q] Queens"
                                puts "[M] Manhattan"
                                puts "[B] Brooklyn"
                                puts "[R] Staten Island"
                                input = gets.strip
                                #use regex to strip brackets
                                Garden.filter_by_borough(input)
                            when "3"
                                puts "Ok! What is your ZIP code?"
                                input = gets.strip
                                Garden.filter_by_zip(input)
                        end
                when "2"
                    all_gardens_detail
                when "3"
                    random_garden
            end
        end
        # input = gets.strip
    end

    def active_garden_count
        puts "a count of the active gardens"
    end


    def all_gardens_detail
        Garden.all.each {|g| index_card(g)}
    end
    
    def random_garden
        index_card(Garden.all.sample)
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