require_relative '../config/environment.rb'

require 'pry'

class Garden
    attr_reader :borough, :gardenname, :multipolygon, :parksid, :status, :zipcode

    @@all = []

    def initialize (borough, gardenname, multipolygon, parksid, status, zipcode)
        @borough = borough
        @gardenname = gardenname
        @multipolygon = multipolygon
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
            "Bronx"
        elsif borough == "M"
            "Manhattan"
        elsif borough == "Q"
            "Queens"
        elsif borough == "R"
            "Staten Island"
        end 
    end


    def self.filter_by_borough(borough)
        @@all.select {|g| g.borough == borough}
        #select creates a new array with all gardens (object IDs) that match it
        #map checks for argument (True/False)
    end

    def self.filter_by_zip(zipcode)
        @@all.select {|g| g.zipcode == zipcode}
    end

    def self.filter_by_status(status)
        @@all.select {|g| g.status == status}
    end

    def zipcode_hash
        zipcode_count = {}

        @@all.each do |g|
            zipcode_count[g.zipcode] = self.filter_by_zip(g.zipcode).count
        end

        zipcode_count

        #was there an easier way to do this?
    end

    def self.top_zipcodes
        sorted_zipcodes = zipcode_hash.sort_by{|k,v| v}.reverse
        # puts "#{sorted_zipcodes[1], sorted_zipcodes[2], sorted_zipcodes[3], sorted_zipcodes[4], sorted_zipcodes[5]}"
    end

    # "11207"=>45,

    # @@all.select{|g| g.borough == "R"}.each {|b| b.index_card}



    #     ------------------------------------
    #     ~*~ Highland Park Children's Garden ~*~
    #      #Active
    #      B - ZIP Code: 11208
    #    ------------------------------------




    # print_garden_by_borough
        #top 5 zip codes, list gardens by name and ID number
    # print_all_gardens_summary
        #total active garden count, drills down by number by boroughs, top 10 zip codes overall
    # print_garden_by_ZIP
        #total active gardens in ZIP code, lists all gardens by name, ID number, and shape
        # full index card format


    #shape_print
        #WKT array into an ASCII art

    #coordinates_to_address
        #take first array pair from multipolygon
        #use it to pull a nearby address on googlemaps
        #OR provide a google maps link that will open a pin

end
