require_relative '../config/environment.rb'
require 'pry'
require 'httparty'

class Scraper

    def self.gardens_api
        site = 'https://data.cityofnewyork.us/resource/p78i-pat6.json'
        page = HTTParty.get(site)
        greenthumb_gardens = page.to_a
        greenthumb_gardens
    end

    def self.create_symbols
        gardens_symbols = []

            self.gardens_api.map do |gardens_hash|
                gardens_symbols << gardens_hash.transform_keys(&:to_sym)
            end

        gardens_symbols
    end

    def self.garden_hashes
        self.create_symbols.map do |g|
            Garden.new(g[:borough], g[:gardenname], g[:multipolygon], g[:parksid], g[:status], g[:zipcode])
        end
    end

end