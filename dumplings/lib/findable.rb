module Findable 

    def find_by_name(name)
        if self.all.detect {|r| r.name == name} == nil
            self.new(name)
        else
            nil
        end
    end

    def find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.new(name)
        end    
    end    

end