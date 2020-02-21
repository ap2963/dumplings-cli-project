class Dumpling
    attr_accessor :name, :country, :region, :blurb
    attr_reader  

    @@all = []
    
    def initialize(name, country, region, blurb) 
        @name  = name
        @country = country 
        @region = region
        @blurb = blurb
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create_dumpling_instances(attributes)
        attributes.each do | attr_hash | 
            dumpling_name = attr_hash[:dumpling_name]
            country = attr_hash[:country]
            region = attr_hash[:region]
            blurb = attr_hash[:blurb]
            #if dumpling_name != "Unknown" && dumpling_name != nil
                dumpling = Dumpling.find_or_create_by_name(dumpling_name, country, region, blurb)
            # else
            #     DumplingApplication.issues[:names] << attr_hash             #should be in bin or something
            #end
            if attr_hash[:dumpling] == nil
                attr_hash[:dumpling] = dumpling
            # else 
            #     DumplingApplication.issues[:instances] << dumpling
            end
        end
    end

	def self.find_or_create_by_name(name, country, region, blurb)
        if self.all.detect{| dumpling_instance | dumpling_instance.name == name} == nil
            self.new(name, country, region, blurb)
        else
            self.all.detect{| dumpling_instance | dumpling_instance.name == name}
        end
    end

    def clear
        @@all.clear
    end

end