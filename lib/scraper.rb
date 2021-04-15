require_relative './garden.rb'
require 'pry'
require 'httparty'


class Scraper

    def self.gardens_api
        site = 'https://data.cityofnewyork.us/resource/p78i-pat6.json'
        page = HTTParty.get(site)
        greenthumb_gardens = page.to_a
        greenthumb_gardens
    end

    # initialize (borough, gardenname, multipolygon, parksid, status, zipcode)

    def self.make_symbols
        gardens_symbols = []

            self.gardens_api.each do |gardens_hash|
                gardens_symbols << gardens_hash.transform_keys(&:to_sym)
            end

        gardens_symbols
    end






end

    # def self.scrape_animal_calendar
    #     #BORING parks idea but I tried nokogiri
    #     site = open("https://www.nycgovparks.org/programs/wildlife-management/calendar/")
    #     page = Nokogiri::HTML(site)
    #     calendar = page.css("div.tab-content").first

    #     animals = []

    #     calendar.css("div.tab-pane").each do |animal|
    #         animals << {
    #             :month => animal.css("h3").text,
    #             :name => animal.css("h4").text,
    #             :info => animal.css("p").text,
    #         }
            
    #     animals

    #     end

    # end