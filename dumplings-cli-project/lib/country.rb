class Country
    attr_accessor :name, :region, :dumplings
    attr_reader :reference

    extend Findable

    @@all = []
    
    def initialize(name)
        @name  = name
        @dumplings = []
        @@all << self
    end

    def self.all
        @@all
    end

    def region
        #looks in reference hash and instantiates as necessary

    end

    def dumplings
        @dumplings << Dumpling.all.select{|d| d.country == self}
    end

    #user can ask what region a country belongs to or what countries are in a region
    def reference
        countries_hash = {}
        world_regions = self.all_countries_and_regions.map{ |a| a[1] }.uniq
        world_regions.each{ |r| countries_hash[r.to_sym] = []}
        self.all_countries_and_regions.each do |a| 
            countries_hash[a[1].to_sym] << a[0]
        end
       
    end
    
end
