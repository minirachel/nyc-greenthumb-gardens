require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

    def scrape_map_hash
        site = "https://nycfridge.com/"
        map = Nokogiri::HTML(open(site))

        fridges = {}

        map.css("div.pin").each do |pin|
            
            binding.pry
        end

        puts "hello"
    end

    def math
        equation = 2 + 2
        equation
    end

end

