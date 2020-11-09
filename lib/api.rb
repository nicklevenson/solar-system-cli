require 'pry'

class Api
    attr_accessor :url, :planet

    def initialize
        @url = 'https://api.le-systeme-solaire.net/rest/bodies'
        # add_planet_by_name(planet)
    end

    # API retrieval
    def get_response
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def parse_response
        JSON.parse(get_response)
    end

    def get_space_bodies
         #queries to retrieve an array of space objects
        parse_response['bodies']
    end

    # OBJECT INIT. adding all planet and moons as objects
    def add_planets
        get_list_of_planets.each {|planet| Planet.new(planet)}
    end
 
    def add_moons
        get_list_of_moons.each {|moon| Moon.new(moon)}
    end


    # Utility - development purposes only. 
   
    # getting a list of planets and moons from the XML query
    def get_list_of_planets
        planets = get_space_bodies.select{|body| body["isPlanet"] == true}
    end

    def get_list_of_moons
        moons = get_space_bodies.select{|body| body["aroundPlanet"] != nil}
    end

    # Access individual planets/moons by name from the XML
    def get_space_body_by_name(name)
        array_of_bodies = get_space_bodies.select{|body| body["englishName"] == name}
        # queries for a particular space object based on name parameter
    end
    def get_space_body_by_latin_name(name)
        array_of_bodies = get_space_bodies.select{|body| body["name"] == name}
        # queries for a particular space object based on name parameter
    end

    # Add a planet by inputed name.
    def add_planet_by_name(name)
        planet = get_space_body_by_name(name)[0]
        Planet.new(planet)
    end





 
end

# api = Api.new
