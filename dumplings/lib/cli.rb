class DumplingApplication
    
     def start
#         welcome_message
        data = Scraper.new.scraped_attributes

         #create_country_instances(data)
        create_region_instances(data)
        binding.pry

#         create_dumpling_instances
#         input = nil
#         default message
#         call_one
     end
    
#     def welcome_message
#         puts "\n"
#         puts "Welcome!"
#         puts "This application will teach you about different dumplings from around the world."
#         puts "Please wait one moment while the content loads."
#         puts "\n"
#     end

    def create_country_instances(hashes)
         hashes.each do | hash | 
            if (name = hash[:country_name])
                Country.find_or_create_by_name(name)
            end
        end
    end

     def create_region_instances(data)
#         region_names = Country.all.map do | country_instance | 
#             @scraper.wiki_scraper_inverter.key(country_instance.name)
#         end
        data.each do |hash|
            region_name = hash[:region_name]

            if region_name != "Unknown" && region_name != nil
                                region = Region.find_or_create_by_name(region_name)
                            end

        end
#         region_names.each do | region_name |
#             
#         end
     end

#     def create_dumpling_instances
#         attributes = @scraper.article_scraper
#         attributes.each do | attributes_array |
#             dumpling_name = attributes_array[0]
#             country_name = attributes_array[1]
#             blurb = attributes_array[2]
#             country = Country.all.select{| country_instance | country_instance.name == country_name}
#             dumpling = Dumpling.find_or_create_by_name(dumpling_name, country)
#         end
#     end

#     def default_message
#         puts "Type a number on your screen to navigate."
#         puts "To quit the application, type 'exit'."
#         puts "\n"
#     end

#     def input_to_index(input)
#         input.to_i - 1
#     end
    
#     def call_one
#         self.default_message
#         self.display_regions_list
#         puts "\n"
#         puts "What would you like to do?"
        
#         input = gets.chomp
#         index = self.input_to_index(input)
        
#         if index >= 0 && index < Region.all.size
#             puts "\n"
#             self.display_countries_list(index)
#             self.call_two
#         elsif input == 'exit'
#             exit
#         else
#             puts "\n"
#             puts "Sorry, that is not a valid response." 
#             self.call_one
#             puts "\n"
#         end
#     end

#     def call_two
#         puts "\n"
#         puts "Type in the number of a country."

#         input = gets.chomp
#         index = self.input_to_index(input)
        
#         if index >= 0 && index < @region.countries_with_dumplings.size 
#             puts "\n"
#             self.display_dumplings_list(index)
#             self.call_three
#         elsif input == 'exit'
#             exit
#         else
#             puts "\n"
#             puts "Sorry, that is not a valid response." 
#             self.call_two
#             puts "\n"
#         end
#     end
    
#     def call_three             
#         if @country.dumplings.size == 1
#             self.display_blurb(1)
#         else 
#             puts "\n"
#             puts "Type in the number of a dumpling."

#             input = gets.chomp
#             index = self.input_to_index(input)

#             if index >= 0 && index <= @country.dumplings.size
#                 self.display_blurb(index)
#             elsif input == 'exit'
#                 exit
#             else
#                 puts "\n"
#                 puts "Sorry, that is not a valid response." 
#                 self.call_three
#                 puts "\n"
#             end
#         end
#     end
        
#     def display_regions_list
#         Region.all.each_with_index{| region_instance, index | puts "#{index + 1} #{region_instance.name}"}         
#     end

#     def display_countries_list(index) 
#         @region = Region.all[index]
#         @region.countries_with_dumplings.each_with_index{| country_instance, index | puts "#{index + 1} #{country_instance.name}"}       #=> list of countries
#     end

#     def display_dumplings_list(index)  
#         @country = @region.countries_with_dumplings[index]
#         @country.dumplings.each_with_index{| dumpling_instance, index | puts "#{index + 1} #{dumpling_instance.name}"}
#     end

#     def display_blurb(index)   
#         @dumpling = @country.dumplings[index]

#         puts @dumpling.name
#         puts "\n"
#         puts @dumpling.blurb
#     end
end



