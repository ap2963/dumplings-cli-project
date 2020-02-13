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

end
