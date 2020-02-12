class Country
    attr_accessor :name, :region, :dumplings

    @@all = []
    
    def initialize(name)
        @name  = name
        @dumplings = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create_country_by_name(name)
        if self.all.detect {|c| c.name == name} == nil
            country = Country.new(name)
            country
        else
            Country.all.detect {|c| c.name == name}
        end
    end

    def region
        #looks in Region's hash
    end

    def dumplings
        @dumplings << Dumpling.all.select{|d| d.country == self}
    end

end

#when does stuff get added to dumplings array?