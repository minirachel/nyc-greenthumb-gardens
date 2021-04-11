require 'open-uri'
require 'pry'
require 'nokogiri'
require 'watir'

class Scraper

    def self.scrape_map_hash
        site = "https://nycfridge.com/"
        page = Nokogiri::HTML(open(site))

        fridges = {}

        map = 

        map.css("div.pin").each do |pin|
            fridges << {
                
            }
            
        end

        puts "hello"
    end

    self.scrape_map_hash

    def math
        equation = 2 + 2
        equation
    end

end

