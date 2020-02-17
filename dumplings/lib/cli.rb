require_relative 'country'
require_relative 'dumpling'
require_relative 'scraper'
require_relative 'region'
require 'pry'
require 'nokogiri'
require 'open-uri'

class DumplingApplication

    def initialize
    	scraper = Scraper.new #creates all instances
        self.call
    end

    def welcome_message
        puts "Welcome!"
        puts "This application will teach you about different dumplings from around the world."
        puts "Type in the number of a region to get started."
        puts "If you would like to read a brief history about dumplings, type 'history'."
        puts "To quit the application, type 'exit'."
        puts "To pull up these options again, type '?'"
    end
    
    def call
        self.welcome_message
        self.display_regions_list
        puts "What would you like to do?"
        input = gets.chomp
        command = input_to_command(input)
        if valid_input?(command) == true
            display_countries_list(command)
        else valid_input?(command) == false
            puts "Sorry, that is not a valid response." 
            puts "Please type in a number from the list, the word 'history' or the word 'exit'."
        end
        until command == "exit"
            self.call
        end
    end

 
    
    def input_to_command(input)
        input.to_i - 1
    end

    def command(input)

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
        counter = 1
        Region.all.each. do |r|
            puts "#{counter} #{r.name}"
            counter += 1
        end
    end

    def display_countries_list
        counter = 1
        Region.all.each. do |r|
            puts "#{counter} #{r.name}"
            counter += 1
        end
    end

    def countries_list
        countries_hash = {}
        Country.all.select{ |c| c.region.name == command? } #name at end of string that user selected 
            counter = 1
            until counter > Country.all.size do
                countries_hash[counter.to_sym] = 
                puts "#{counter}. #{c.capitalize}"
                counter += 1
            end
        end
    end       
    
    def dumplings_list
        ###
    end

    def display_dumplings_list
        ###
    end

end

cli = DumplingApplication.new

