
class Country
    attr_accessor :region #from wikitable scraper
    attr_reader :name, :dumplings #from other scraper

    @@all = []
        
    def initialize(name)
        @name = name
        unless self.name == nil
            @@all << self
        end
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
    end    

   # def dumplings
   #     Dumpling.all.select{|d| d.country == self}
   # end


end
