
class Cli

    def start
        api = Api.new
        api.add_planets
    end
    
    def list_planets
       Planet.all.collect{|planet| planet.englishName}

    end


end

