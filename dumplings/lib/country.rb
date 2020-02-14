require_relative 'findable'

class Country
    attr_accessor :name, :region, :dumplings
    attr_reader :reference

    @@all = []
        
    def initialize(name)
        @name = name
        @dumplings = []
        @@all << self
        #self.region
    end

    def self.all
        @@all
    end

    def region
    #looks in reference hash (find key for value in hash)m and instantiates a new region if necessary
    #self.region = region_instance

    end
 

    def find_or_create_by_name(name)
        if self.all.detect{| r | r.name == name} == nil
            self.new(name)
        else
            self.all.detect{| r | r.name == name}
        end    
    end    

       
end
    
