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
            puts "Welcome to GreenThumb the unofficial NYC Parks GreenThumb app."
            puts "What are you interested in learning about today? [enter a number]"
            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
            puts "[1] How many active gardens are there?"
            puts "[2] Show me a list of all gardens in the city, please."
            puts "[3] I'd like to see a random garden. Now."
            puts "[4] Just say a sentence."
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
                                puts "There are a total of #{Garden.all.count} gardens in New York City."
                                puts "#{Garden.filter_by_borough("X").count} in the Bronx."
                                puts "#{Garden.filter_by_borough("Q").count} in Queens."
                                puts "#{Garden.filter_by_borough("M").count} in Manhattan."
                                puts "#{Garden.filter_by_borough("B").count} in Brooklyn."
                                puts "#{Garden.filter_by_borough("M").count} in Staten Island."
                                # puts "The ZIP codes with the most gardens are: #{Garden.top_zipcodes}"
                                #number of garden count total
                                #number of gardens by borough
                                #top 5 zip codes
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
                                #number of garden count
                                #top 5 in ZIP
                                #lists name and garden ID
                                    #option to drill down
                            when "3"
                                puts "Ok! What is your ZIP code?"
                                input = gets.strip
                                Garden.filter_by_zip(input)
                                #number of garden count
                        end
                when "2"
                    all_gardens_detail
                when "3"
                    random_garden
                when "4"
                    puts "This is a sentence to not run the index card function."
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