class Dumpling
    attr_accessor :name, :country
    attr_reader :region

    extend Findable

    @@all = []
    
    def initialize(name, country = nil)
        @name  = name
        @country = country
        @@all << self
    end

    def self.all
        @@all
    end

    def region
        self.country.region
    end

end