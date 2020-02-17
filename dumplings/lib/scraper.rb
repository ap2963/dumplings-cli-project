require_relative 'country'
require_relative 'dumpling'
require_relative 'findable'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    attr_reader :country_dumpling_array, :regions_array, :reference_hash
	
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
        doc = Nokogiri::HTML(open('https://meta.wikimedia.org/wiki/List_of_countries_by_regional_classification'))
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
        @region_country_pair = []
        full_array = self.get_table_columns.first.split("\n")
        until full_array.size == 0
            full_array.pop
            @region_country_pair << full_array.pop(2)
        end
    end

    def create_reference_regions
        self.get_countries_and_regions
        new_array = []
        @region_country_pair.each{| p | new_array << p[1]}
        @regions_array = new_array.delete_if{|x| x == "Unknown"}.uniq
    end
    
    def create_reference_countries
      self.get_countries_and_regions
      @countries_array = []
      counter = 0
      @regions_array.size.times do | p |
        @countries_array[counter] = @region_country_pair.select{|p| p[1] == @regions_array[counter]}.map{| p | p[0]}
        counter += 1
      end
    end
    
    def create_reference_hash
      self.create_reference_regions
      self.create_reference_countries
      @reference_hash = Hash[@regions_array.map{|x| [x, @countries_array[@regions_array.find_index(x)]]}]
    end
    
    def create_country_and_dumpling_instances
        self.create_country_dumpling_array.each do | p | 
            country_name = p[1]
            dumpling_name = p[0]
            region_name = 
            country = Country.find_or_create_by_name(country_name)
            dumpling = Dumpling.find_or_create_by_name(dumpling_name, country)    
        end
    end

    def create_region_instances
        Country.all.each 
    end

end
