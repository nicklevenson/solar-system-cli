# This class initializes moon objects. A moon belongs to a planet.
class Moon
    extend Findable
    include CliHelperMethods
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

    def my_planet
        # gives the aroundPlanet attr a real planet object (rather than its initial name value)
        planet = Planet.all.select{|planet| planet.id == @aroundPlanet["planet"]}[0]
        @aroundPlanet = planet
    end
end