require_relative 'country'

class Dumpling
    attr_accessor :name, :country
    attr_reader :region

    @@all = []
    
    def initialize(name, country) #gets from pair_array
        @name  = name
        @country = country
        @@all << self
        self.country.dumplings << self
    end

    def self.all
        @@all
    end

    def region
        self.country.region
    end

	def self.find_or_create_by_name(name, country)
        if self.all.detect {| r | r.name == name} == nil
            self.new(name, country)
        else
            nil
        end
    end

end