class Country
    attr_accessor :name, :dumplings, :region
    attr_reader 

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
            #if country_name != "Unknown" && country_name != nil
                country = Country.find_or_create_by_name(country_name, region)
            # else
            #     DumplingApplication.issues[:names] << attr_hash
            #end
            if attr_hash[:country] == nil
                attr_hash[:country] = country
            # else 
            #     DumplingApplication.issues[:instances] << country
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
