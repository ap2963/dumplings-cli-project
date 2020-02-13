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


    def initialize(name)
        @name = name
        @@all << self
    end
    
    def self.all
        @@all
    end

    def countries_with_dumplings

    end

    def dumplings

    end

    def dumplings
        @dumplings << Dumpling.all.select{|d| d.country.region == self}
    end



