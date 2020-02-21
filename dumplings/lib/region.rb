class Region
    attr_accessor :name
    attr_reader :countries_with_dumplings, :dumplings

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
    end
    
    def self.all
        @@all
    end

    def self.create_region_instances(attributes)
        attributes.each do | attr_hash |
            region_name = attr_hash[:region_name]
        
            #if region_name != "Unknown" && region_name != nil
                region = Region.find_or_create_by_name(region_name)
            # else
            #     DumplingApplication.issues[:names] << attr_hash
            #end
            if attr_hash[:region] == nil
                attr_hash[:region] = region
            # else 
                # DumplingApplication.issues[:names] << region
            end
        end     
    end

    def self.find_or_create_by_name(name)
        if self.all.detect{| region_instance | region_instance.name == name} == nil
            self.new(name)
        else
            self.all.detect{| region_instance | region_instance.name == name}
        end
    end
    
    def countries_with_dumplings
        Country.all.select{| country_instance | country_instance.region == self}
    end

    def dumplings
        Dumpling.all.select{| dumpling_instance | dumpling_instance.region == self}
    end

    def clear
        @@all.clear
    end

end

