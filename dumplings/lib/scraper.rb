require_relative 'country'
require_relative 'dumpling'
require_relative 'findable'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    attr_reader 
	
    def initialize
        
        self.create_reference_hash
        self.create_country_dumpling_array
        #create.blurb_array

    end
	
    def get_dumplings_article 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        article = doc.css(".vw-post-content")
        article
    end

    def create_country_dumpling_array
        pair_array = []
        self.get_dumplings_article.css("h4").each do | h |
            pair_array << h.to_s[4...-6]
        end
        @country_dumpling_array = pair_array.map{| p | p.split(" \u2013 ").flatten}
    end

    #def create_blurb_array
    #end
    
#scrapes wikitable for countries and their regions
    def get_wikitable
        doc = Nokogiri::HTML(open("3"))
    end
            
    def get_table_rows
        self.get_wikitable.xpath("//tr")
    end

    def get_table_columns
        self.get_table_rows.map do |c|
            c.xpath("//td").text
        end
    end

    def get_countries_and_regions
        full_array = self.get_table_columns.first.split("\n")
        until full_array.size == 0
            full_array.pop
            @region_country_pair << full_array.pop(2)
        end
    end

    def create_reference_hash
        self.get_countries_and_regions
        africa = @region_country_pair.select{| p | p[1] == "Africa"}
        arab_states = @region_country_pair.select{| p | p[1] == "Arab States"}
        asia = @region_country_pair.select{| p | p[1] == "Asia & Pacific"}
        europe = @region_country_pair.select{| p | p[1] == "Europe"}
        middle_east = @region_country_pair.select{| p | p[1] == "Middle east"}
        north_america = @region_country_pair.select{| p | p[1] == "North America"}
        south_america = @region_country_pair.select{| p | p[1] == "South/Latin America"}

        @reference_hash = {
            "africa" => africa.map{|p| p[0]},
            "arab_states" => arab_states.map{|p| p[0]},
            "asia" => asia.map{|p| p[0]},
            "europe" => europe.map{|p| p[0]},
            "middle_east" => middle_east.map{|p| p[0]},
            "north_america" => north_america.map{|p| p[0]},
            "south_america" => south_america.map{|p| p[0]} 
        }
    end

end


