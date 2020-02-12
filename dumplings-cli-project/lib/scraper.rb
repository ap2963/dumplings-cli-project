require 'nokogiri'
require 'open-uri'

class Scraper 
    
    def get_page 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
    end

    def get_article
        self.get_page.css(".vs-post-content clearfix")
    end

    def get_pair
        self.get_article.css("h4").text
    end

    def get_country
        self.get_pair each do |p|
            country.name = p.split(" - ")[1]
        end
    end

    def make_country
        self.get_country.each do |vs|
    end

    def get_dumpling
        self.get_pair each do |p|
            dumpling.name = p.split(" - ")[0]
            dumpling.country = p.split(" - ")[1]
        end
    end

    def make_dumpling

    end

end