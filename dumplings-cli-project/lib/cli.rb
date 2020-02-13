require 'pry'

class DumplingApplication

    def initialize
        @scraper = Scraper.new
        @scraper.create_country
        @scraper.create_dumpling
        @scraper.

    end

    def call
        puts "Welcome!"
        puts "This application will teach you about different dumplings from around the world."
        puts "Type in the number of a region to get started."
        puts "If you would like to read a brief history about dumplings, type 'history'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.chomp
        command = input_to_index(input)

        until command == "exit"
            self.call
        end
    end

    #only list countries for which country.region == the region chosen by the user (associated with numbered key hash)

    
    
    def inititalize_list_of_countries #based on imput
        country

    end

    def input_to_index(input)
        input.to_i - 1
    end


    def valid_input
        if command >= 0 && command <= some_array.size || input = "history" || input = "exit"
    end

    def command(input)

    end
    
    def display_list
        #need method that looks at reference hash and displays an array of relevant regions
        #puts each item
    end

    def list_countries
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
    
    def list_dumplings

    end

    def list_regions
        list_of_regions = Country.all.find{|c| }
    end


Country.all.select{| c | c.region == self} 


end

#Go through list of dumplings, instantiating a dumpling first, then a country, then having the country look up its region in the built in reference guide

#Scrape dumpling website
#Scrape table
#Create reference
#Create dumpling instances (65)
#Create country instances (?)
#Look up region in reference
#Create region instance
#Display call method
#Display list of regions
#Display list of countries in that region
#Display list of dumplings in that country
