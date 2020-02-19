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
        Dumpling.all.select{| dumpling_instance | dumpling_instance.country.region == self}
    end

end

