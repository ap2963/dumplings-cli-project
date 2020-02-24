class Country
    attr_accessor :name, :region
    attr_reader :dumplings

    @@all = []
        
    def initialize(name, region)
        @name = name
        @region = region
        @@all << self
    end

    def self.all
        @@all
    end
    
    def self.create_country_instances(attributes)
        attributes.each do | attr_hash | 
            country_name = attr_hash[:country_name]
            region = attr_hash[:region] 
            country = Country.find_or_create_by_name(country_name, region)
            if attr_hash[:country] == nil
                attr_hash[:country] = country
            end
        end
    end

    def self.find_or_create_by_name(name, region)
        if self.all.detect{| country_instance | country_instance.name == name} == nil
            self.new(name, region)
        else
            self.all.detect{| country_instance | country_instance.name == name}
        end
    end    

    def dumplings
        Dumpling.all.select{| dumpling_instance | dumpling_instance.country == self}
    end

    def clear
        @@all.clear
    end

end
