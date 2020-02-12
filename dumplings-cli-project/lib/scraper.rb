require 'nokogiri'
require 'open-uri'

class Scraper 
    
    def get_article 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        article = doc.css(".vw-post-content")
        article
    end

    def get_pair
        pair_array = []
        self.get_article.css("h4").each do |p|
            pair_array << p.to_s[4...-6]
        end
        pair_array.map do |p|
            p.split(" \u2013 ")
        end
    end

    def make_country
        self.get_pair.each do |p|
            country_name = p[1]
            country = Country.new(country_name) #if it doesn't already exist
        end
    end
        

    def make_dumpling
        self.get_pair.each do |p|
            dumpling_name = p[0]
            dumpling = Dumpling.new(dumpling_name, country)
            if Country.all.detect {|c| c.name == country_name} != nil
                dumpling.country = Country.all.detect {|c| c.name == country_name}
            else
                dumpling.country = Country.new(country_name)
            end 
        end
    end

    def get_blurb

    end
end



