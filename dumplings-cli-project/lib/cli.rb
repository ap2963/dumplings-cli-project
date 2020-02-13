require 'pry'

class DumplingApplication
    attr_accessor 

    def initialize

    end

    def call
        puts "Welcome!"
        puts "This application will teach you about different dumplings from around the world."
        puts "Type in the number of a region to get started."
        puts "If you would like to read a brief history about dumplings, type 'history'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        command = gets.chomp
        until command == "exit"
            self.call
        end
    end
    
    def list_regions

    end

    def list_countries

    end

    def list_dumplings

    end


end

