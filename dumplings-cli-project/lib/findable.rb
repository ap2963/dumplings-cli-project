module Findable 

    def find_by_name(name)
        if self.all.detect {|r| r.name == name} == nil
            self.all.new(name)
        else
            nil
        end
    end

    def create_by_name(name)
        if self.find_by_name == nil
            self.all.new(name)
        end    
    end    

    def find_or_create_by_name(name)
        self.find_by_name
        self.create_by_name
    end

end