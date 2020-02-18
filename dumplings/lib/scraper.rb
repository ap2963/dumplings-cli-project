require_relative 'country'
require_relative 'dumpling'
require_relative 'region'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
    attr_accessor :blurb_array, :dumpling_hash, :country_region_hash
    
    def self.article_scraper 
        article = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        blurb_array = []
        article.css('p').each do | blurb |
            if blurb.search('img') != true && blurb.text != ""
                blurb_array << blurb.text
            end
        end

        counter = 2
        article.css('h4').collect do | dumpling_attributes |
            dumpling_hash = {
                :dumpling_name => dumpling_attributes.text.split(" \u2013 ")[0],
                :country_name => dumpling_attributes.text.split(" \u2013 ")[1],
                :blurb => blurb_array[counter]
                }
            counter += 1
            dumpling_hash
        end
    end
    
    
    def self.wiki_table_scraper
        wiki_table = Nokogiri::HTML(open('https://meta.wikimedia.org/wiki/List_of_countries_by_regional_classification'))
        wiki_table.css('tbody').css('tr').collect do | row |
            country_region_hash = {
                :country => row.css('td')[0],
                :region => row.css('td')[1]
            }
            country_region_hash
        end
    end


    def stragglers
        stragglers = @country_dumpling_array.select{|a| a.size != 2}
        stragglers.map{|a| @country_dumpling_array.index(a)}.reverse #19, 60
    end

  

    def create_region_country_dumpling_instances
        self.create_reference_hash
        self.create_country_dumpling_array.each do | p | 
            
            country_name = p[1]
            case country_name 
            when "England" || "Scotland"
                country_name = "United Kingdom"
            when "Korea"
                country_name = "South Korea"
            when "Dominican Replublic"
                country_name = "Dominican Republic"
            when "Russia"
                country_name = "Russian Federation"
            when "Palestine"
                country_name = "Palestinian Territory"
            else 
                country_name = p[1]
            end
             
            dumpling_name = p[0]
            region_name = @reference_hash.each{|k , v| break k if v.include?(country_name)}
            
            country = Country.find_or_create_by_name(country_name)
            dumpling = Dumpling.find_or_create_by_name(dumpling_name, country)
            region = Region.find_or_create_by_name(region_name)
            country.region = region
        end
    end

end
