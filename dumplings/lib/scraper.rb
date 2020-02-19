class Scraper

    def article_scraper
        @info ||= article.css('h4')[0..-3].map do | heading |
            data = {dumpling: heading.text.split(/ [^\w\s]+ ?/)[0],
                    country: heading.text.split(/ [^\w\s]+ ?/)[1]
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

    def article
        Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
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
        #start = Time.now
        #puts "#{(Time.now - start)}"
        article_scraper.map do | c_hash |
           
            case c_hash[:country]
            when "England", "Scotland"
                c_hash[:country] = "United Kingdom"
            when "Korea"
                c_hash[:country] = "South Korea"
            when "Dominican Replublic"
                c_hash[:country] = "Dominican Republic"
            when "Russia"
                c_hash[:country] = "Russian Federation"
            when "Palestine"
                c_hash[:country] = "Palestinian Territory"
            else
            end
            country = c_hash[:country]
            c_hash[:region_name] = wikitable_scraper[country]

            c_hash

        end
    end

end
