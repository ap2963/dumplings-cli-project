
class Country
    attr_accessor :dumplings
    attr_reader :name

    @@all = []
        
    def initialize(name)
        @name = name
        @dumplings = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create_by_name(name)
        if self.all.detect{| r | r.name == name} == nil
            self.new(name)
        else
            self.all.detect{| r | r.name == name}
        end
        region_name = self.get_region.to_s
        region = Region.find_or_create_by_name(region_name)
        self.region = region 
    end    

    def get_region
        Scraper.new.reference_hash.each{| k, v | break k if v.include?(self.name)}
    end


        if key != nil
            new_region = Region.new(key.to_s)
        end
        Region.all.each{|r| r.countries.includes? == key.to_s}
    end

    def dumplings
        Dumpling.all.select{|d| d.country = self}
    end
       
end
    
