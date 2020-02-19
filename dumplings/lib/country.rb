class Country
    attr_accessor 
    attr_reader :name, :dumplings, :region

    @@all = []
        
    def initialize(name)
        @name = name

        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create_by_name(name)
        if self.all.detect{| country_instance | country_instance.name == name} == nil
            self.new(name)
        else
            self.all.detect{| country_instance | country_instance.name == name}
        end
    end    

    def dumplings
        Dumpling.all.select{| dumpling_instance | dumpling_instance.country == self}
    end


    def region
        region_name = Scraper.wikitable_scraper.select{| hash | hash[:country_name] == self.name}[:region]
        Region.all.select{| region_instance | region_instance.name == region_name}
    end
end
