class Country
    attr_accessor :name, :region, :dumplings

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
        #looks in Region's hash
    end

    def dumplings
        @dumplings << Dumpling.all.select{|d| d.country == self}
    end

end
