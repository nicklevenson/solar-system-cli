# This class initializes moon objects
class Moon
    extend Findable
    attr_accessor 
    @@all = []

    def initialize(moon)
        moon.each do |key,value| 
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end
end