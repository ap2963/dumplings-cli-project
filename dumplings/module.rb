require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def article
        Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
    end

    def article_scraper
        @info ||= article.css('h4')[0..-3].map do | heading |
            data = {dumpling_name: heading.text.split(/ [^\w\s]+ ?/)[0],
                    country_name: heading.text.split(/ [^\w\s]+ ?/)[1]
                    }
            next_el = heading.next_element
            while next_el && next_el.name != "h4"
                if next_el.search('img') != true && next_el.text != ""
                    data[:blurb] = next_el.text
                end
                next_el = next_el.next_element
            end
            data
        end
    end

    def wikitable_scraper
        unless @regions
            wikitable = Nokogiri::HTML(open('https://meta.wikimedia.org/wiki/List_of_countries_by_regional_classification'))
            @regions = {}
            wikitable.css('tbody').css('tr')[1..-1].each do | row |
                columns = row.css('td')[0..1]
                @regions[columns.first.text.chomp] = columns.last.text.chomp
            end
        end
        @regions
    end

    def scraped_attributes
        article_scraper.map do | attributes_hash |
            case attributes_hash[:country_name]
            when "England", "Scotland"
                attributes_hash[:country_name] = "United Kingdom"
            when "Korea"
                attributes_hash[:country_name] = "South Korea"
            when "Dominican Replublic"
                attributes_hash[:country_name] = "Dominican Republic"
            when "Russia"
                attributes_hash[:country_name] = "Russian Federation"
            when "Palestine"
                attributes_hash[:country_name] = "Palestinian Territory"
            else
            end
            country_name = attributes_hash[:country_name]
            attributes_hash[:region_name] = wikitable_scraper[country_name]
            attributes_hash
        end
    end

    def history_scraper
        history = Nokogiri::HTML(open('https://www.history.com/news/delightful-delicious-dumplings'))
        history.css("div.l-grid--content-body").css('p').map do | p |
            paragraphs = p.text
        end
    end

end

s = Scraper.new
binding.pry
