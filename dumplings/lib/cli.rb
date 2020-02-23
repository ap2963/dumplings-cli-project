require 'tty-prompt'

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
        puts "\n"
        banner
        puts "WELCOME!".colorize(:yellow).blink
        puts "\n"
        puts "Learn about 65 types of dumplings from around the world."
        puts "\n"
        puts "One moment while the content loads..."
        puts "\n"
    end

    def banner
        puts "     ___                              ___                               "
        puts "    (   )                            (   ).-.                           "
        puts "  .-.| |___  ___ ___ .-. .-.    .-..  | |( __)___ .-.   .--.     .--.   "
        puts " /   \ (   )(   |   )   '   \  /    \ | |(''\"|   )   \ /    \  /  _  \ "
        puts "|  .-. || |  | | |  .-.  .-. ;' .-,  ;| | | | |  .-. .;  ,-. '. .' `. ; "
        puts "| |  | || |  | | | |  | |  | || |  . || | | | | |  | || |  | || '   | | " 
        puts "| |  | || |  | | | |  | |  | || |  | || | | | | |  | || |  | |_\_`.(___)"
        puts "| |  | || |  | | | |  | |  | || |  | || | | | | |  | || |  | (   ). '.  "
        puts "| '  | || |  ; ' | |  | |  | || |  ' || | | | | |  | || '  | || |  `\ | "
        puts "' `-'  /' `-'  / | |  | |  | || `-'  '| | | | | |  | |'  `-' |; '._,' ' "
        puts " `.__,'  '.__.' (___)(___)(___) \__.'(___|___|___)(___)`.__. | '.___.'  "
        puts "                              | |                      ( `-' ;          "
        puts "                             (___)                      `.__.           "
    end
    
    def create_objects(attributes)
        Region.create_region_instances(attributes)
        Country.create_country_instances(attributes)
        Dumpling.create_dumpling_instances(attributes)
    end
    
    def instructions_message
        puts ">> ".colorize(:yellow) + "Enter a number".colorize(:cyan) + " to navigate to the region, country, or dumpling." 
        puts ">> ".colorize(:yellow) + "To read about the history of dumplings," + " enter 'history'".colorize(:cyan) + "."
        puts ">> ".colorize(:yellow) + "For more options," + " enter 'help'".colorize(:cyan) + "."
    end

    def default_message
        puts "\n"
        puts "What would you like to do?".colorize(:yellow)
    end

    def input_to_index
        @index = @input.to_i - 1
    end

    def h_loop
        @input = gets.chomp
        until @input == 'done' || @input == 'exit' do
            puts "\n"
            puts "Sorry, that is not a valid input. Please try again.".colorize(:yellow) 
            self.h_loop
        end
        if @input == 'done'
            h_back
        elsif @input == 'exit'
            exit
        end
    end

    def help_screen
        puts "\n"
        print TTY::Box.frame "back        Go back one step", "back!       Go back to first step", "exit        Quit application", "help        View options", "history     Read about the history of dumplings", "<list #>    Navigate to region, country, or dumpling"
        puts "\n"
        puts "Enter 'done' to return.".colorize(:yellow) 
    end
    
    def call_one
        @steps = []
        puts "\n"
        display_regions_list
        default_message
        get_input_one
    end

    def get_input_one
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true || (@index >= 0 && @index < Region.all.size) == true do
            puts "Sorry, that is not a valid input. Please try again.".colorize(:yellow)
            puts "\n"
            get_input_one
        end
        if @index >= 0 && @index < Region.all.size 
            @region = Region.all[@index]
            @steps << @region
            self.call_two
        end
        valid_input_one
    end

    def call_two
        puts "\n"
        display_countries_list
        default_message
        get_input_two
    end

    def get_input_two
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true || (@region.countries_with_dumplings[@index].dumplings.size == 1 && @index != -1) || (@region.countries_with_dumplings[@index].dumplings.size != 1 && @index >= 0 && @index < @region.countries_with_dumplings.size) == true do
            puts "Sorry, that is not a valid input. Please try again.".colorize(:yellow) 
            puts "\n"
            get_input_two
        end
        if @region.countries_with_dumplings[@index].dumplings.size == 1 && @index != -1
            @country = @region.countries_with_dumplings[@index]
            @steps << @country
            @dumpling = @country.dumplings[0]
            @steps << @dumpling
            self.call_four
        elsif @region.countries_with_dumplings[@index].dumplings.size != 1 && @index >= 0 && @index < @region.countries_with_dumplings.size 
            @country = @region.countries_with_dumplings[@index]
            @steps << @country
            self.call_three
        end
        valid_input
    end

    def call_three
        puts "\n"
        display_dumplings_list
        default_message
        get_input_three
    end

    def get_input_three
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true || (@index >= 0 && @index < @country.dumplings.size) == true do
            puts "Sorry, that is not a valid input. Please try again.".colorize(:yellow)
            puts "\n" 
            get_input_three
        end
        if @index >= 0 && @index < @country.dumplings.size
            @dumpling = @country.dumplings[@index]
            @steps << @dumpling
            self.call_four
        end
        valid_input
    end

    def call_four
        puts "\n"
        display_blurb
        default_message
        get_input_four
    end


    def get_input_four
        @input = gets.chomp
        input_to_index
        until ['exit', 'back', 'back!', 'history', 'help'].include?(@input) == true do
            puts "Sorry, that is not a valid input. Please try again.".colorize(:yellow) 
            "\n"
            get_input_four
        end
        valid_input
    end

    def valid_input_one   
        if @input == 'exit'
            puts "Thank you for using Dumplings."
            puts "Goodbye!"
            exit        
        elsif @input == 'back'
            puts "You are on the first page. Please try again.".colorize(:yellow) 
            puts "\n"
            get_input_one
        elsif @input == 'back!'
            puts "You are on the first page. Please try again.".colorize(:yellow) 
            puts "\n"
            get_input_one
        elsif @input == 'history'
            history
            "\n"
        elsif @input == 'help'
            "\n"
            help_screen
            h_loop
            "\n"        
        end     
    end

    def valid_input    
        if @input == 'exit'
            puts "\n"
            puts "Thank you for using Dumplings.".colorize(:cyan)
            puts "Goodbye!".colorize(:cyan)
            puts "\n"
            exit        
        elsif @input == 'back'
            back
            "\n"
        elsif @input == 'back!'
            back_all
            "\n"
        elsif @input == 'history'
            history
            h_loop
            "\n"
        elsif @input == 'help'
            help_screen
            h_loop
            "\n"
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
        puts @dumpling.name.colorize(:cyan)
        puts "\n"
        puts @dumpling.blurb.colorize(:cyan)
        @steps << @dumpling.blurb
    end

    def h_back
        if @steps.size == 4
            call_four #countries
        elsif @steps.size == 3
            call_four #countries
        elsif @steps.size == 2
            call_three #regions
        elsif @steps.size == 1
            call_two
        elsif @steps.size == 0
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
            call_three #countries
        elsif @steps.size == 2
            @steps.pop
            call_two #regions
        elsif @steps.size == 1
            @steps.pop
            call_one #regions
        end 
    end

    def back_all
        call_one
    end

    def history
        puts "\n"
        @history.each do | paragraph | 
            puts paragraph
            puts "\n" 
        end
        puts "Enter 'done' to return.".colorize(:yellow)
        h_loop
    end
end

