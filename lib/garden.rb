require_relative '../config/environment.rb'

require 'pry'

class Garden
    attr_reader :borough, :gardenname, :multipolygon, :parksid, :status, :zipcode

    @@all = []

    def initialize (borough, gardenname, multipolygon, parksid, status, zipcode)
        @borough = borough
        @gardenname = gardenname
        @multipolygon = multipolygon
        @parksid = status
        @zipcode = zipcode
        @@all << self
    end

    def self.all
        @@all
    end

    def self.print_gardens
        zipcode_gardens = @@all.select {|g| g.zipcode == "10458"}
        puts zipcode_gardens
    end

end
