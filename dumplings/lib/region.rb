class Region
    attr_accessor :name, :countries_with_dumplings
    attr_reader :dumplings

#instantiates with name 
#has a hash with country/region relationship?
#has many dumplings through countries
#has several countries with dumplings
#keeps track of its countries that have been instantiated
#keeps track of its own instances
#is instantiated when country from new region is instantiated
#country is responsible for looking up relationship??

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
        if self.all.detect{| r | r.name == name} == nil
            self.new(name)
        else
            self.all.detect{| r | r.name == name}
        end
    end
    
    def countries_with_dumplings
        Country.all.select{|c| c.region == self}
    end


    def dumplings
        @dumplings << Dumpling.all.select{|d| d.country.region == self}
    end

end

