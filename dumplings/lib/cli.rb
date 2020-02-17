require_relative 'country'
require_relative 'dumpling'
require_relative 'scraper'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class DumplingApplication
    attr_reader :country_list, :dumpling_list

    def initialize
    	scraper = Scraper.new #creates all instances
        self.welcome_message
        self.call
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
    
    def call
        self.default_message
        self.display_regions_list
        puts "\n"
        puts "What would you like to do?"
        
        input = gets.chomp
        index = input.to_i - 1
        
        if index >= 0 && index <= Region.all.size
            puts "\n"
            self.call_two(index)
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call
            puts "\n"
        end
    end

    def call_two(index)
        @country_list = Country.all.select{|c| c.region == Region.all[index]}
        self.display_countries_list(index)
        
        puts "\n"
        puts "Type in the number of a country."

        input = gets.chomp
        index = input.to_i - 1
        puts "\n"
        
        if index >= 0 && index <= @country_list.size 
            puts "\n"
            self.call_three(index)
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call_two
            puts "\n"
        end
    end

    def display_countries_list(index)
        @country_list.each_with_index{|c, i| puts "#{i+1} #{c.name}"}
    end

    
    def call_three(index)
        @dumpling_list = Dumpling.all.select{|d| d.country == @country_list[index]}
        self.display_dumplings_list(index)
        
        puts "\n"
        puts "Type in the number of a dumpling."

        input = gets.chomp
        index = input.to_i - 1
        puts "\n"

        if index >= 0 && index <= @dumpling_list.size
            exit
        elsif input == 'exit'
            exit
        else
            puts "\n"
            puts "Sorry, that is not a valid response." 
            self.call_three
            puts "\n"
        end
    end
    
    def display_dumplings_list(index)
        @dumpling_list.each_with_index{|d, i| puts "#{i+1} #{d.name}"}
    end

#if input is not valid -> puts 
    def valid_input?(command)
        if command >= 0 && command <= some_array.size || input = "history" || input = "exit" || input = "?"
            true
        else
            false
        end
    end


    
    def display_regions_list
        Region.all.each_with_index{|r, i| puts "#{i+1} #{r.name}"}
    end





end

cli = DumplingApplication.new

