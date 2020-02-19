class Dumpling
    attr_accessor :name, :country, :blurb
    attr_reader :region 

    @@all = []
    
    def initialize(name, country) 
        @name  = name
        self.country = country
        self.blurb = Scraper.new.article_scraper.select{| hash | hash[:dumpling_name] == self.name}
        @@all << self
    end

    def self.all
        @@all
    end

	def self.find_or_create_by_name(name, country)
        if self.all.detect{| dumpling_instance | dumpling_instance.name == name} == nil
            self.new(name, country)
        else
            self.all.detect{| dumpling_instance | dumpling_instance.name == name}
        end
    end

    def region
        self.country.region
    end

end