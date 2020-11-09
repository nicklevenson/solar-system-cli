class Planet 
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

    def self.find_by_name(name)
        self.all.select{|planet| planet.englishName == name}[0]
    end

    def find_moons
        #search moon class for matching moon objects
       Moon.all.select{|moon| moon.aroundPlanet["planet"] == @id}  
    end

end
