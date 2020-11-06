
class Cli

    def start
        api = Api.new
        api.add_planets
       
        api.add_moons
        
        binding.pry
    end
    
    def list_planets
       Planet.all.collect{|planet| planet.englishName}

    end


end

