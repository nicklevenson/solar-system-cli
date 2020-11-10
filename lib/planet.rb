# This class initializes planets and gives them moons from the moon class. A planet has many moons.
class Planet 
    extend Findable
    attr_accessor :my_moons
    @@all = []

    def initialize(planet)
        planet.each do |key,value| 
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
        @@all << self
    end


    def self.all
        @@all
    end

    def find_moons
        Moon.all.select{|moon| moon.aroundPlanet == self}
    end

end

