class Dumpling
    attr_accessor :name, :country

    @@all = []
    
    def initialize(name, country = nil)
        @name  = name
        @country = country
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create_dumpling_by_name(name)
        if self.all.detect {|d| d.name == name} == nil
            dumpling = Dumpling.new(name)
        else
            Dumpling.all.detect {|d| d.name == name}
        end
    end

    #has a region by association

end