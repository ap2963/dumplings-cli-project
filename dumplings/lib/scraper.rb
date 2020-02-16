require_relative 'country'
require_relative 'dumpling'
require_relative 'findable'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    attr_reader :country_dumpling_pair, :world_regions, :reference_hash, :region_country_pair
	
    def initialize
        @region_country_pair = []
        
        #self.get_country_dumpling_pair
        #self.get_countries_and_regions
        #self.create_country_and_dumpling_instances
        #self.create_blurb
        #self.create_countries_and_regions_hash
    end
	
#scrapes website for information about dumplings
    def get_article 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        article = doc.css(".vw-post-content")
        article
    end

    def get_country_dumpling_pair
        pair_array = []
        self.get_article.css("h4").each do | h |
            pair_array << h.to_s[4...-6]
        end
        @country_dumpling_pair = pair_array.map{| p | p.split(" \u2013 ").flatten}
    end
    
#scrapes wikitable for countries and their regions
    def get_table
        doc = Nokogiri::HTML(open("3"))
    end
            
    def table_rows
        self.get_table.xpath("//tr")
    end

    def table_columns
        self.table_rows.map do |c|
            c.xpath("//td").text
        end
    end

#creates an array of arrays that contain a country and its region - [country, region]
    def get_countries_and_regions
        full_array = self.table_columns.first.split("\n")
        until full_array.size == 0
            full_array.pop
            @region_country_pair << full_array.pop(2)
        end
    end

    def create_reference_hash
        self.get_countries_and_regions
        africa = @region_country_pair.select{| p | p[1] == "Africa"}

        south_america = @region_country_pair.select{| p | p[1] == "South/Latin America"}
        europe = @region_country_pair.select{| p | p[1] == "Europe"}

        asia = @region_country_pair.select{| p | p[1] == "Asia & Pacific"}
        
        middle_east = @region_country_pair.select{| p | p[1] == "Middle east"}
        north_america = @region_country_pair.select{| p | p[1] == "North America"}
        arab_states = @region_country_pair.select{| p | p[1] == "Arab States"}

        @reference_hash = {
            "africa" => africa.map{|p| p[0]},
            "south_america" => south_america.map{|p| p[0]},
            "europe" => europe.map{|p| p[0]},
            "asia" => asia.map{|p| p[0]},
            "middle_east" => middle_east.map{|p| p[0]},
            "arab_states" => arab_states.map{|p| p[0]},
            "north_america" => north_america.map{|p| p[0]}
        }
    end

end


scraper = Scraper.new
binding.pry

