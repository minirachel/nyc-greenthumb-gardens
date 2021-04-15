require_relative './scraper.rb'

class Garden
    attr_reader :borough, :gardenname, :multipolygon, :parksid, :status, :zipcode

    def initialize (borough, gardenname, multipolygon, parksid, status, zipcode)
        @borough = borough
        @gardenname = gardenname
        @multipolygon = multipolygon
        @parksid = status
        @zipcode = zipcode
    end

end
