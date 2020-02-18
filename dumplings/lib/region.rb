class Region
    attr_accessor :name, :countries_with_dumplings
    attr_reader :dumplings

    @@all = []

    def initialize(name)
        @name = name
        unless self.name.class != String
            @@all << self
        end
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
        @dumplings << Dumpling.all.select{|d| d.country.region == self}
    end

end

