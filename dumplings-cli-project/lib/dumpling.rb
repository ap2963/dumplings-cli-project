class Dumpling
    attr_accessor :name, :country
    attr_reader :region

    @@all = []
    
    def initialize(name, country = nil)
        @name  = name
        @country = country
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_name(name)
        if self.all.detect {|d| d.name == d name} == nil
            country = self.new(name)
            country
        else
            nil
        end
    end

    def self.create_by_name(name)
        if self.find_by_name == nil
            country = Country.new(name)
        end    
        country
    end    

    def self.find_or_create_by_name(name)
        self.find_by_name
        self.create_by_name
    end
    
    
    
    
    def self.find_or_create_by_name(name)
        if self.all.detect {|d| d.name == name} == nil
            dumpling = Dumpling.new(name)
        else
            Dumpling.all.detect {|d| d.name == name}
        end
    end

    def region
        self.country.region
    end

    #has a region by association

end