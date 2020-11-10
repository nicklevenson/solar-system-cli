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
        @my_moons = find_moons
    end

    def self.all
        @@all
    end

    def find_moons
        #search moon class for matching moon objects
       Moon.all.select{|moon| moon.aroundPlanet["planet"] == @id}  
    end

end

