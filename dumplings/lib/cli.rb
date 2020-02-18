require_relative 'country'
require_relative 'dumpling'
require_relative 'scraper'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class DumplingApplication

    def initialize
    end

Scraper.blurb_scraper
Scraper.article_scraper
Scraper.wikitable_scraper

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







    def welcome_message
        puts "\n"
        puts "Welcome!"
        puts "This application will teach you about different dumplings from around the world."
        puts "\n"
    end

    def default_message
        puts "Type in the number of a region."
        puts "To quit the application, type 'exit'."
        puts "\n"
    end

    def input_to_index(input)
        input.to_i - 1
    end
    
    def call_one
        self.default_message
        self.display_regions_list
        puts "\n"
        puts "What would you like to do?"
        
        input = gets.chomp
        index = self.input_to_index(input)
        
        if index >= 0 && index <= @first_array.size
            puts "\n"
            self.display_countries_list(index)
            self.call_two
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call_one
            puts "\n"
        end
    end

    def call_two
        puts "\n"
        puts "Type in the number of a country."

        input = gets.chomp
        index = self.input_to_index(input)
        
        if index >= 0 && index <= @second_array.size 
            puts "\n"
            self.display_dumplings_list(index)
            self.call_three
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call_two
            puts "\n"
        end
    end
    
    def call_three             
        puts "\n"
        puts "Type in the number of a dumpling."

        input = gets.chomp
        index = self.input_to_index(input)

        if index >= 0 && index <= @third_array.size
            self.display_blurb(index)
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call_three
            puts "\n"
        end
    end
        
    def display_regions_list
        Dumpling.all.map{|d| d.country.region}.uniq.each_with_index{|d, i| puts "#{i+1} #{d.country.region.name}"}
        @first_array = Dumpling.all.map{|d| d.country.region}.uniq
        @first_array.each_with_index{|d, i| puts "#{i+1} #{d.country.region.name}"}         #list of regions
    end

    def display_countries_list(index) 
        @second_array = Dumpling.all.select{|d| d.country.region == @first_array[index]}
        @second_array.each_with_index{|d, i| puts "#{i+1} #{d.country.name}"}         #=> list of countries
    end

    def display_dumplings_list(index)  
        @third_array = Dumpling.all.select{|d| d.country == @second_array[index]}
        @third_array.each_with_index{|d, i| puts "#{i+1} #{d.name}"}      #=> list of dumplings
    end

    def display_blurb(index)   
        i = Dumpling.all.index(@third_array[index])
        puts scraper.blurb_array[i]
    end
        
end




