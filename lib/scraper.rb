require 'open-uri'
require 'pry'
require 'nokogiri'
require 'watir'
require 'webdrivers'

class Scraper

    def self.scrape_map_hash
        browser = Watir::Browser.new
        browser.goto("https://nycfridge.com/")
        js_doc = browser.element(css: "div.container_Container__X1m1k").wait_until(&:present?)
        map = Nokogiri::HTML(js_doc.inner_html)
        desired_results = map.css("div.container_Container__X1m1k").first
        
        binding.pry
        # site = open("https://nycfridge.com/")
        # page = Nokogiri::HTML(site)
        # map = page.css("div.pin").first
        # binding.pry

        # fridges = {}

        # map = 

        # map.css("div.pin").each do |pin|
        #     fridges << {
                
        #     }
            
        # end

        puts "hello"
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