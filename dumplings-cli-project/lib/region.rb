class Region
    attr_accessor 
    attr_reader 

#instantiates with name 
#has a hash with country/region relationship
#has many dumplings through country
#keeps track of its countries that have been instantiated




def create_region_keys
    countries_hash = {}
    world_regions = self.all_countries_and_regions.map{ |a| a[1] }.uniq
    world_regions.each{ |r| countries_hash[r.to_sym] = []}
    self.all_countries_and_regions.each do |a| 
        countries_hash[a[1].to_sym] << a[0]
    end 
end

end
