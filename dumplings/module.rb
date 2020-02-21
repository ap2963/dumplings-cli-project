#attributes = Scraper.new.scraped_attributes

@steps = []

@region = Region.all[index]
@country = @region.countries_with_dumplings[index]
@dumpling = @country.dumplings[index]


def back
    back_hash = {
    1.to_sym => display_regions_list,
    2.to_sym => display_countries_list,
    3.to_sym => display_dumplings_list,
    4.to_sym => display_blurb
    }
    back_hash[@steps.size.to_sym]
    @steps.pop
end


def call_one_mod
    if index >= 0 && index < Region.all.size
        puts "\n"
        self.display_countries_list(index)
        self.call_two
    elsif index > Region.all.size
        puts "\n"
        puts "That number is not on the list! Please try again."
        get_index
    else 
        general_options
    end
end



def general_options
    case @input
    when 'exit'
        puts "Thank you for using Dumplings."
        puts "Goodbye!"
        exit
    when 'back'  
        back
    when 'back!'
    when 'history'
    when 'help'
        help_screen
        help_loop
    end
end

@input_array = ['exit', 'back', 'back!', 'help', 'history']

def call_loop    
    until @input_array.detect{| input | input == @input} || (@index >= 0 && @index < Region.all.size) do
        puts "\n"
        puts "Sorry, that is not a valid input." 
        self.call
    end
    general_options
end




def help_loop
    input = gets.chomp
    until input == 'r' do
        puts "\n"
        puts "Sorry, that is not a valid input."
        self.help_loop
    end
end