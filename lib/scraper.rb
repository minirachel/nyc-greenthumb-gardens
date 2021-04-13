require 'pry'
require 'httparty'

class Scraper

    def self.scrape_greengardens
        site = 'https://data.cityofnewyork.us/resource/p78i-pat6.json'
        page = HTTParty.get(site)
        gardens = page.to_a

        binding.pry

        info = []

        # reports.css("div.tab-pane").each do |requests|
        #     info << {

        #     }
        # end
            
        info
    
    end

    self.scrape_greengardens

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