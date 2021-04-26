require_relative '../config/environment.rb'
require 'pry'

class CommandLineInterface
    def initialize
        Scraper.gardens_api
        Scraper.garden_hashes
    end

    def run
        menu
    end

    #possibly scrape for Greenthumb websites through Parks ID? search?

    def menu
        input = ""

            puts " "
            puts "Welcome to the unofficial NYC Parks GreenThumb app".cyan.invert
            puts "What are you interested in learning about today?".cyan.invert
            puts " "
        while input != "9"
            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
            puts " "
            puts "[enter a number]".cyan
            puts "#{"[1]".cyan} #{"How many".bold} gardens are there?"
            puts "#{"[2]".cyan} Show me a list of #{"all gardens".bold} in the city, please."
            puts "#{"[3]".cyan} I'd like to see #{"a random garden".bold}. Now."
            puts "#{"[9]".cyan} Please, let me #{"exit".bold}."
            puts " "
        input = gets.strip
            case input
                when "1"
                    Inkjet.indent do
                    puts " "
                    puts "Great question! How would you like me to pull the report?"
                    puts " "
                    puts "#{"[1]".cyan} in all of New York City"
                    puts "#{"[2]".cyan} in my borough"
                    puts "#{"[3]".cyan} in my ZIP"
                    end
                    input = gets.strip
                    #use regex to strip brackets
                        case input
                            when "1"
                                Inkjet.indent(4) do
                                puts " "
                                puts "There are a total of #{"#{Garden.all.count} gardens".magenta} in New York City."
                                puts " "
                                puts "Bronx: #{"#{Garden.filter_by_borough("X").count}".magenta}"
                                puts "Queens: #{"#{Garden.filter_by_borough("Q").count}".magenta}"
                                puts "Manhattan: #{"#{Garden.filter_by_borough("M").count}".magenta}"
                                puts "Brooklyn: #{"#{Garden.filter_by_borough("B").count}".magenta}"
                                puts "Staten Island: #{"#{Garden.filter_by_borough("M").count}".magenta}"
                                puts " "
                                puts "The most vegetative ZIP codes are:" 
                                puts " "
                                Garden.top_zipcodes("all")
                                puts " "
                                end
                            when "2"
                                Inkjet.indent(4) do
                                puts " "
                                puts "Ok! Which borough are you in?"
                                puts "#{"[X]".cyan} Bronx"
                                puts "#{"[Q]".cyan} Queens"
                                puts "#{"[M]".cyan} Manhattan"
                                puts "#{"[B]".cyan} Brooklyn"
                                puts "#{"[R]".cyan} Staten Island"
                                end
                                input = gets.strip
                                #use regex to strip brackets
                                    Inkjet.indent(6) do
                                    puts "There are #{"#{Garden.filter_by_borough(input).count}".magenta} in #{"#{Garden.translate_borough(input)}".yellow}."
                                    puts "The most vegetative ZIP codes in your borough are:"
                                    puts " "
                                    Garden.top_zipcodes(input)
                                    puts " "
                                    puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                                    puts " "
                                    puts "Here is a list of garden names in your borough."
                                    puts "#{"Type in the garden ID to learn more about a specific location:".cyan}"
                                    borough_one_liner(input)
                                    puts "#{"Type in the garden ID to learn more about a specific location:".cyan}"
                                    puts ""
                                    input = gets.strip
                                        #chomp for spaces?
                                        #switch drill_down to helper method
                                        #IF drill_down = true -> output parks info ELSE main menu
                                       drill_down = Garden.all.detect {|g| g.parksid == input}
                                       index_card(drill_down)
                                    end
                            when "3"
                                Inkjet.indent(4) do
                                puts " "
                                puts "Ok! What is your ZIP code?"
                                input = gets.strip
                                puts "There are #{"#{Garden.filter_by_zip(input).count}".magenta} GreenThumb Gardens in #{"#{input}".yellow}."
                                puts ""
                                puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                                puts ""
                                puts "Here's a list of garden names in your borough."
                                zip_one_liner(input)
                                puts "#{"Type in the garden ID to learn more about a specific location:".cyan}"
                                    input = gets.strip
                                    #chomp for spaces?
                                        drill_down = Garden.all.detect {|g| g.parksid == input}
                                        index_card(drill_down)
                                end
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
            puts ""
            puts " ~*~ #{"#{g.gardenname}".blue} ~*~"
            puts "  #{"#{g.parksid}".magenta}"
            puts "  #{Garden.translate_borough(g.borough)} - ZIP Code: #{"#{g.zipcode}".yellow}"
            puts ""
        end
        
    # puts " #{shape_print}"
    #value is nil due to puts
    #look at music CLI - NEEDS TO TAKE IN AN ARGUMENT?!
    #why tap not map
    end

    def borough_one_liner(input)
        Garden.filter_by_borough(input).each do |g|
            puts "~*~ #{"#{g.gardenname}".blue} - #{g.parksid}"
            puts " "
        end
    end

    def zip_one_liner(input)
        Garden.filter_by_zip(input).each do |g|
            puts "~*~ #{"#{g.gardenname}".blue} - #{g.parksid}"
            puts " "
        end
    end


end