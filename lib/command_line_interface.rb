require_relative '../config/environment.rb'

require 'pry'

class CommandLineInterface
    def initialize
        Scraper.gardens_api
        Scraper.garden_hashes
    end
    #switched make_gardens to initialize?

    def run
        menu
    end

    def menu
        input = ""

        while input != "9"
            puts " "
            puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
            puts "What are you interested in learning about today? [enter a number]"
            puts " "
            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
            puts " "
            puts "[1] How many gardens are there?"
            puts "[2] Show me a list of all gardens in the city, please."
            puts "[3] I'd like to see a random garden. Now."
            puts "[4] Just say a sentence."
            puts "[9] Let me leave."
            puts " "
        input = gets.strip
            case input
                when "1"
                    puts " "
                    puts "Great question! How would you like me to pull the report?"
                    puts "[1] in all of New York City"
                    puts "[2] in my borough"
                    puts "[3] in my ZIP"
                    input = gets.strip
                    #use regex to strip brackets
                        case input
                            when "1"
                                puts " "
                                puts "There are a total of #{Garden.all.count} gardens in New York City."
                                puts "#{Garden.filter_by_borough("X").count} in the Bronx."
                                puts "#{Garden.filter_by_borough("Q").count} in Queens."
                                puts "#{Garden.filter_by_borough("M").count} in Manhattan."
                                puts "#{Garden.filter_by_borough("B").count} in Brooklyn."
                                puts "#{Garden.filter_by_borough("M").count} in Staten Island."
                                puts "The top 5 ZIP codes are:" 
                                puts " "
                                Garden.top_zipcodes("all")
                            when "2"
                                puts " "
                                puts "Ok! Which borough are you in?"
                                puts "[X] Bronx"
                                puts "[Q] Queens"
                                puts "[M] Manhattan"
                                puts "[B] Brooklyn"
                                puts "[R] Staten Island"
                                input = gets.strip
                                #use regex to strip brackets
                                    puts "There are #{Garden.filter_by_borough(input).count} in #{Garden.translate_borough(input)}."
                                    puts "The most vegetative ZIP codes in your borough are:"
                                    puts " "
                                    Garden.top_zipcodes(input)
                                    puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                                    puts "Here's a list of garden names in your borough."
                                    puts "Type in the garden ID to learn more about a specific location:"
                                    borough_one_liner(input)
                                    input = gets.strip
                                        #chomp for spaces?
                                       drill_down = Garden.all.detect {|g| g.parksid == input}
                                       index_card(drill_down)
                            when "3"
                                puts " "
                                puts "Ok! What is your ZIP code?"
                                input = gets.strip
                                puts "There are #{Garden.filter_by_zip(input).count} GreenThumb Gardens in #{input}."
                                puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                                puts "Here's a list of garden names in your borough."
                                puts "Type in the garden ID to learn more about a specific location:"
                                zip_one_liner(input)
                                    input = gets.strip
                                    #chomp for spaces?
                                        drill_down = Garden.all.detect {|g| g.parksid == input}
                                        index_card(drill_down)
                        end
                when "2"
                    all_gardens_detail
                when "3"
                    random_garden
                when "4"
                    puts "This is a sentence to not run the index card function."
            end
        end
    end

    def all_gardens_detail
        Garden.all.each {|g| index_card(g)}
    end
    
    def random_garden
        index_card(Garden.all.sample)
    end

    def index_card(garden)
        garden.tap do |g|
            puts "- - - - - - - - - - - - - - - - - - - - - - - - - - "
            puts " ~*~ #{g.gardenname} ~*~"
            puts "  ##{g.parksid}"
            puts "  #{Garden.translate_borough(g.borough)} - ZIP Code: #{g.zipcode}"
        end
        
    # puts " #{shape_print}"
    #value is nil due to puts
    #look at music CLI - NEEDS TO TAKE IN AN ARGUMENT?!
    #why tap not map
    end

    def borough_one_liner(input)
        Garden.filter_by_borough(input).each do |g|
            puts "~*~ #{g.gardenname} - #{g.parksid}"
            puts " "
        end
    end

    def zip_one_liner(input)
        Garden.filter_by_zip(input).each do |g|
            puts "~*~ #{g.gardenname} - #{g.parksid}"
            puts " "
        end
    end




end