require_relative '../config/environment.rb'
require 'pry'

class CommandLineInterface
    def initialize
        Scraper.gardens_api
        Scraper.garden_hashes
    end

    def run
        Multipolygon.all.first.arraycount
    end

    def menu
        input = ""

            puts " "
            puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
            puts "What are you interested in learning about today? [enter a number]"
            puts " "
        while input != "9"
            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
            puts "menu"
            puts "[1] How many gardens are there?"
            puts "[2] Show me a list of all gardens in the city, please."
            puts "[3] I'd like to see a random garden. Now."
            puts "[9] Please, let me exit."
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
                                puts " "
                                puts "Bronx: #{Garden.filter_by_borough("X").count}"
                                puts "Queens: #{Garden.filter_by_borough("Q").count}"
                                puts "Manhattan: #{Garden.filter_by_borough("M").count}"
                                puts "Brooklyn: #{Garden.filter_by_borough("B").count}"
                                puts "Staten Island: #{Garden.filter_by_borough("M").count}"
                                puts " "
                                puts "The most vegetative ZIP codes are:" 
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