class Country
    attr_accessor :name, :region, :dumplings

    @@all = []
    
    def initialize(name)
        @name  = name
        @dumplings = []
    end

    def self.all
        @@all
    end

    def find_or_create_country_by_name(name)
        if Country.all.detect {|c| c.name == name} == nil
            Country.new(name)
        else
            Country.all.detect {|c| c.name == name}
        end
    end

    def region
        #looks in Region's hash
    end

end