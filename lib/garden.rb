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
    end

    def self.filter_by_zip(zipcode)
        @@all.select {|g| g.zipcode == zipcode}
    end

    def self.filter_by_status(status)
        @@all.select {|g| g.status == status}
    end


    def self.zipcode_hash(borough)
        zipcode_count = {}

        self.filter_by_borough(borough).map do |g|
            zipcode_count[g.zipcode] = self.filter_by_zip(g.zipcode).count
        end

        zipcode_count
    end

    def self.print_top_zipcodes(borough)
        highest_sorted_zipcodes = self.zipcode_hash(borough).sort_by{|k,v| v}.reverse
        highest_sorted_zipcodes.first(5).map {|k,v| puts "#{"#{v}".magenta} gardens in #{"#{k}".yellow}".indent(4)}
    end


end
