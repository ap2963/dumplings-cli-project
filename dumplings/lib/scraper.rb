require_relative 'country'
require_relative 'dumpling'
require_relative 'findable'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    attr_reader :country_dumpling_pair, :world_regions, :region_country_pair, :reference_hash 
	
    def initialize
        @country_dumpling_pair = nil
        @world_regions = nil
        @region_country_pair = []
        @reference_hash = {}
        
        self.country_dumpling_pair
        self.create_country_and_dumpling_instances
        self.get_blurb
        self.create_reference_hash
        self.create_region_instances
    end
	
#scrapes website for information about dumplings
    def get_article 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        article = doc.css(".vw-post-content")
        article
    end

    def get_country_dumpling_pair
        pair_array = []
        self.get_article.css("h4").each do |p|
        pair_array << p.to_s[4...-6]
        end
        @country_dumpling_pair = pair_array.map{| p | p.split(" \u2013 ").flatten}
        @country_dumpling_pair
    end
    
    def create_country_and_dumpling_instances
        self.get_country_dumpling_pair.each do | p | 
            country_name = p[1]
            dumpling_name = p[0]
            country = Country.find_or_create_by_name(country_name)
            dumpling = Dumpling.find_or_create_by_name(dumpling_name, country)    
        end 
    end
  
    def get_blurb
        blurb_array = []
        blurb_array << self.get_article.css("p").text
    end

#scrapes wikitable for countries and their regions
    def get_table
        doc = Nokogiri::HTML(open("https://meta.wikimedia.org/wiki/List_of_countries_by_regional_classification"))
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
        @region_country_pair
    end

    def create_reference_hash
        @world_regions = self.get_countries_and_regions.map{| a | a[1] }.uniq
        @world_regions.each{| r | @reference_hash[r.to_sym] = []}
        self.get_countries_and_regions.each do | a | 
            @reference_hash[a[1].to_sym] = a[0]
        end
    end
            
    def create_region_instances
        Country.all.each do | c |
#find region key that has country's name as a string as a value
        region_name = @reference_hash.key(c.name)
        Region.find_or_create_by_name(region_name)
        end
    end

scraper = Scraper.new
binding.pry
end
