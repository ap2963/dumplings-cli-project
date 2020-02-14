class Dumpling
    attr_accessor :name, :country
    attr_reader :region

    @@all = []
    
    def initialize(name, country) #gets from pair_array
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

		    def find_by_name(name)
        if self.all.detect {|r| r.name == name} == nil
            self.all.new(name)
        else
            nil
        end
    end

    def create_by_name(name)
        if self.find_by_name == nil
            self.all.new(name)
        end    
    end    

    def find_or_create_by_name(name)
        self.find_by_name(name)
        self.create_by_name(name)
    end

end