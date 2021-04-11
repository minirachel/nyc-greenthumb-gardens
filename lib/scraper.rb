require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

    def self.scrape_map_hash
        # browser = Watir::Browser.new
        # browser.goto("https://nycfridge.com/")
        # js_doc = browser.element(css: "div.container_Container__X1m1k").wait_until(&:present?)
        # map = Nokogiri::HTML(js_doc.inner_html)
        # desired_results = map.css("div.container_Container__X1m1k").first
        # browser.quit()
        
        site = open("https://www.nycgovparks.org/programs/wildlife-management/calendar/")
        page = Nokogiri::HTML(site)
        calendar = page.css("div.tab-content").first

        animals = []

        calendar.css("div.tab-pane").each do |animal|
            animals << {
                :month => animal.css("h3").text,
                :name => animal.css("h4").text,
                :info => animal.css("p").text,
            }
            
        animals
        binding.pry
        end

    end

    self.scrape_map_hash

    def math
        equation = 2 + 2
        equation
    end

end

# includes? "popupBubble".children.text == NAME AND ADDRESS
# #(Attr:0x3ff84f21c730 {
#     name = "class",
#     value = "StyledBox-sc-13pk1d4-0 hcvciW Modal_popupBubble__1Z61H"