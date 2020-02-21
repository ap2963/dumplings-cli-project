require 'colorize'
require 'colorized_string'

class DumplingApplication

    def start
        welcome_message
        attributes = Scraper.new.scraped_attributes
        @history = Scraper.new.history_scraper
        create_objects(attributes)
        instructions_message
        input = nil
        call_one
    end

    def welcome_message
        puts "\n"
        puts "Welcome!"
        puts "This application will teach you about different dumplings from around the world."
        puts "One moment while the content loads."
        puts "\n"
    end

    def create_objects(attributes)
        Region.create_region_instances(attributes)
        Country.create_country_instances(attributes)
        Dumpling.create_dumpling_instances(attributes)
    end
    
    def instructions_message
        puts "To navigate, enter the number next to a region, country, or dumpling." 
        puts "To read a short history about dumplings, enter 'history'."
        puts "To view a full list of your options, enter 'help'."
        puts "\n"
    end
    
    def default_message
        puts "What would you like to do?".black.on_light_white
        puts "\n"
    end

    def input_to_index
        @index = @input.to_i - 1
    end

    def help_loop
        @input = gets.chomp
        until @input == 'done' do
            puts "\n"
            puts "Sorry, that is not a valid input."
            puts "\n"
            self.help_loop
        end
        if @input == 'done'
            help_back
        end
    end

    def help_screen
        puts "{number}    Navigate to region, country, or dumpling" 
        puts "back        Go back one step"
        puts "back!       Go back to first step"
        puts "\n"
        puts "history     Read short history about dumplings"
        puts "\n"
        puts "help        View options"
        puts "exit        Quit application"
        puts "\n"  
        puts "Enter 'done' to return"
    end
    

    def call_one
        @steps = []
        display_regions_list
        default_message
        get_input_one
    end

    def get_input_one
        @input = gets.chomp
        input_to_index
        until ['exit', 'history', 'help'].include?(@input) == true || (@index >= 0 && @index < Region.all.size) == true do
            puts "That is not a valid input."
            get_input_one
        end
        if @index >= 0 && @index < Region.all.size 
            @region = Region.all[@index]
            @steps << @region
            puts "\n"
            self.call_two
        end
        valid_input_one
    end

    def call_two
        display_countries_list
        default_message
        get_input_two
    end

    def get_input_two
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true || (@region.countries_with_dumplings[@index].dumplings.size == 1 && @index != -1) || (@region.countries_with_dumplings[@index].dumplings.size != 1 && @index >= 0 && @index < @region.countries_with_dumplings.size) == true do
            puts "That is not a valid input."
            get_input_two
        end
        if @region.countries_with_dumplings[@index].dumplings.size == 1 && @index != -1
            @country = @region.countries_with_dumplings[@index]
            @steps << @country
            @dumpling = @country.dumplings[0]
            @steps << @dumpling
            self.display_blurb
            self.call_four
        elsif @region.countries_with_dumplings[@index].dumplings.size != 1 && @index >= 0 && @index < @region.countries_with_dumplings.size 
            @country = @region.countries_with_dumplings[@index]
            @steps << @country
            puts "\n"
            self.call_three
        end
        valid_input
    end

    def call_three
        display_dumplings_list
        default_message
        get_input_three
    end

    def get_input_three
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true || (@index >= 0 && @index < @country.dumplings.size) == true do
            puts "That is not a valid input."
            get_input_three
        end
        if @index >= 0 && @index < @country.dumplings.size
            @dumpling = @country.dumplings[@index]
            @steps << @dumpling
            self.display_blurb
            self.call_four
        end
        valid_input
    end

    def call_four
        default_message
        get_input_four
    end


    def get_input_four
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true do
            puts "That is not a valid input."
            "/n"
            get_input_four
        end
        valid_input
    end

    def valid_input_one   
        if @input == 'exit'
            puts "Thank you for using Dumplings."
            puts "Goodbye!"
            exit        
        elsif @input == 'history'
            @history.each do | paragraph | 
                puts paragraph 
                puts "\n"
            end
        elsif @input == 'help'
            "/n"
            help_screen
            help_loop
            "/n"        
        end     
    end

    def valid_input    
        if @input == 'exit'
            puts "Thank you for using Dumplings."
            puts "Goodbye!"
            exit        
        elsif @input == 'back'
            back
            "/n"
        elsif @input == 'back!'
            back_all
            "/n"
        elsif @input == 'history'

        elsif @input == 'help'
            help_screen
            help_loop
            "/n"
        end    
    end


    def display_regions_list
        Region.all.each_with_index{| region_instance, index | puts "#{index + 1}  #{region_instance.name}"}         
    end

    def display_countries_list
        @region.countries_with_dumplings.each_with_index{| country_instance, index | puts "#{index + 1}  #{country_instance.name}"}       #=> list of countries
    end

    def display_dumplings_list  
        @country.dumplings.each_with_index{| dumpling_instance, index | puts "#{index + 1}  #{dumpling_instance.name}"}
    end

    def display_blurb   
        puts "\n"
        puts @dumpling.name
        puts "\n"
        puts @dumpling.blurb
        @steps << @dumpling.blurb
        puts "\n"
        puts "\n"
    end

end

def help_back
    if @steps.size == 4
        call_four #countries
    elsif @steps.size == 3
        call_three #countries
    elsif @steps.size == 2
        call_two #regions
    elsif @steps.size == 1
        call_one
    end 
end

def back
    if @steps.size == 4 && @steps[1].dumplings.size == 1
        @steps.pop
        @steps.pop
        call_two #countries
    elsif @steps.size == 4 && @steps[1].dumplings.size != 1
        @steps.pop
        call_three #dumplings
    elsif @steps.size == 3
        @steps.pop
        call_two #countries
    elsif @steps.size == 2
        @steps.pop
        call_one #regions
    else 
        puts "You are on the first page."
        puts "\n"
    end 
end

def back_all
    if @steps.size == 1
        puts "You are on the first page."
        puts "\n"
    else 
        call_one
    end
end

def history
    @history.each do | paragraph | 
        puts paragraph 
        puts "\n"
    end
    help_back
end