require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 
    
    #Scraper for information about dumplings
    
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
        pair_array.map do |p|
            p.split(" \u2013 ")
        end
    end

    def create_country
        self.get_country_dumpling_pair.each do |p|
            country_name = p[1]
            Country.find_or_create_by_name(country_name)
        end
    end
        
    def create_dumpling
        country = self.create_country
        self.get_country_dumpling_pair.each do |p|
            dumpling_name = p[0]
            dumpling = Dumpling.find_or_create_by_name(dumpling_name, country)           
        end
    end
            
    def get_blurb
    end

    #Scraper for countries and regions around the world

    def get_table
        doc = Nokogiri::HTML(open("https://meta.wikimedia.org/wiki/List_of_countries_by_regional_classification"))
    end
    
    def rows
        self.get_table.xpath("//tr")
    end

    def columns
        self.rows.map do |c|
            c.xpath("//td").text
        end
    end

    def all_countries_and_regions
        full_array = self.columns.first.split("\n")
        modified_array = []
        until full_array.size == 0
            full_array.pop
            modified_array << full_array.pop(2)
        end
        modified_array
    end


end
    