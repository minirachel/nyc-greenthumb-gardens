require_relative '../config/environment.rb'
require 'pry'

class Garden
    attr_reader :borough, :gardenname, :multipolygon, :parksid, :status, :zipcode

    @@all = []

    def initialize (borough, gardenname, multipolygon, parksid, status, zipcode)
        @borough = borough
        @gardenname = gardenname
        @multipolygon = multipolygon
        Multipolygon.new(@multipolygon["coordinates"])
        @parksid = parksid
        @status = status
        @zipcode = zipcode
        @@all << self
    end

    def self.all
        @@all
    end

    def self.translate_borough(borough)
        if borough == "B"
            "Brooklyn"
        elsif borough == "X"
            "the Bronx"
        elsif borough == "M"
            "Manhattan"
        elsif borough == "Q"
            "Queens"
        elsif borough == "R"
            "Staten Island"
        end 
    end


    def self.filter_by_borough(borough)
        if borough == "all"
            @@all
        else
            @@all.select {|g| g.borough == borough}
        end

        #select creates a new array with all gardens (object IDs) that match it
        #map checks for argument (True/False)
    end

    def self.filter_by_zip(zipcode)
        @@all.select {|g| g.zipcode == zipcode}
    end

    def self.filter_by_status(status)
        @@all.select {|g| g.status == status}
    end


    def self.zipcode_hash(borough)
        zipcode_count = {}

        self.filter_by_borough(borough).each do |g|
            zipcode_count[g.zipcode] = self.filter_by_zip(g.zipcode).count
        end

        zipcode_count
    end

    def self.top_zipcodes(borough)

        sorted_zipcodes = self.zipcode_hash(borough).sort_by{|k,v| v}.reverse
        sorted_zipcodes.first(5).each {|k,v| puts "#{v} gardens in #{k}"}
        # puts "#{sorted_zipcodes[1], sorted_zipcodes[2], sorted_zipcodes[3], sorted_zipcodes[4], sorted_zipcodes[5]}"
    end




    #shape_print
        #WKT array into an ASCII art

    #coordinates_to_address
        #take first array pair from multipolygon
        #use it to pull a nearby address on googlemaps
        #OR provide a google maps link that will open a pin

end
