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
            puts "[enter a number]".blue
            puts "#{"[1]".cyan} #{"How many".cyan} gardens are there?"
            puts "#{"[2]".cyan} Show me a list of #{"all gardens".cyan} in the city, please."
            puts "#{"[3]".cyan} Show me a list of the gardens #{"in my borough".cyan}."
            puts "#{"[4]".cyan} Show me a list of the gardens #{"in my ZIP code".cyan}."
            puts "#{"[5]".cyan} I'd like to see #{"a random garden".cyan}. Now."
            puts "#{"[6]".cyan} I know my garden's name or ID number, can I #{"search for it".cyan}?"
            puts "#{"[9]".cyan} Please, let me #{"exit".cyan}."
            puts " "

            input = gets.strip
            case input

                #How many?
                when "1"
                    puts " "
                    puts "Great question! How would you like me to pull the report?"
                    puts " "
                    puts "#{"[1]".cyan} in all of New York City"
                    puts "#{"[2]".cyan} in my borough"
                    puts "#{"[3]".cyan} in my ZIP"
    
                    input = gets.strip

                    case input
                        #citywide count
                        when "1"
                            citywide_garden_count_report

                        #borough count
                        when "2"
                            puts " "
                            puts "Ok! Which borough are you in?"
                            puts "#{"[X]".cyan} Bronx"
                            puts "#{"[Q]".cyan} Queens"
                            puts "#{"[M]".cyan} Manhattan"
                            puts "#{"[B]".cyan} Brooklyn"
                            puts "#{"[R]".cyan} Staten Island"

                            input = gets.strip

                            puts "There are #{"#{Garden.filter_by_borough(input).count}".magenta} in #{"#{Garden.translate_borough(input)}".yellow}."
                            puts "The most vegetative ZIP codes in your borough are:"
                            puts " "
                            Garden.top_zipcodes(input)

                            puts " "
                            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"

                        #zip count
                        when "3"
                            puts " "
                            puts "Ok! What is your ZIP code?"
                            input = gets.strip
                            puts "There are #{"#{Garden.filter_by_zip(input).count}".magenta} GreenThumb Gardens in #{"#{input}".yellow}."
                            puts ""
                            puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                            puts "Would you like a list of the gardens in your ZIP? Y/N"
                            zip_one_liner(input)
                            # input = gets.strip

                            # if input == "Y"
                            #     zip_one_liner(input)
                            # else

                    end

                #all gardens
                when "2"
                    all_gardens_detail

                #borough report
                when "3"
                    puts " "
                    puts "Ok! Which borough are you in?"
                    puts "#{"[X]".cyan} Bronx"
                    puts "#{"[Q]".cyan} Queens"
                    puts "#{"[M]".cyan} Manhattan"
                    puts "#{"[B]".cyan} Brooklyn"
                    puts "#{"[R]".cyan} Staten Island"
                    

                    input = gets.strip

                    puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                    puts " "
                    puts "Here is a list of garden names in your borough."
                    borough_one_liner(input)

                    puts "#{"Type in the garden ID to learn more about a specific location:".cyan}"
                    puts ""
                    input = gets.strip

                    drill_down = find_by_parksid(input)
                    index_card(drill_down)
            

                #zip report
                when "4"
                    puts " "
                    puts "Ok! What is your ZIP code?"
                    input = gets.strip

                    puts "~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~ * ~"
                    puts ""
                    puts "Here's a list of garden names in your borough."
                    zip_one_liner(input)
                    puts "#{"Type in the #{"garden ID".magenta} to learn more about a specific location:".cyan}"
                    input = gets.strip

                    drill_down = find_by_parksid(input)
                    index_card(drill_down)

                #random report
                when "5"
                    random_garden

                #search
                when "6"
                    puts "Type in the garden name or ID to pull up more info:"
                    input = gets.strip
                    search_function(input)
            end
        end
    end

    def search_function(input)
        if find_by_gardenname(input)
            found_garden = find_by_gardenname(input)
            index_card(found_garden)
        elsif find_by_parksid(input)
            found_garden = find_by_parksid(input)
            index_card(found_garden)
        else
            puts "Sorry, I can't find that park. Are you sure you're spelling it correctly? Try again:"
            input = gets.strip
            search_function(input)
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
            puts "  ~*~ #{"#{g.gardenname}".blue} ~*~"
            puts "  #{"#{g.parksid}".magenta} (#{g.status})"
            puts "  #{Garden.translate_borough(g.borough)} - ZIP Code: #{"#{g.zipcode}".yellow}"
            puts ""
        end
    end

    def borough_one_liner(input)
        Garden.filter_by_borough(input).each do |g|
            puts "~*~ #{"#{g.gardenname}".blue} - #{"#{g.parksid}".magenta}"
            puts " "
        end
    end

    def zip_one_liner(input)
        Garden.filter_by_zip(input).each do |g|
            puts "~*~ #{"#{g.gardenname}".blue} - #{"#{g.parksid}".magenta}"
            puts " "
        end
    end

    def citywide_garden_count_report
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

    def find_by_parksid(input)
        Garden.all.detect {|g| g.parksid == input}
    end

    def find_by_gardenname(input)
        Garden.all.detect {|g| g.gardenname == input}
    end


end