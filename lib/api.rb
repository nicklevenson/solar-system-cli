require 'pry'

class Api
    attr_accessor :url

    def initialize
        @url = 'https://api.le-systeme-solaire.net/rest/bodies'
    end

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

    def get_list_of_planets
        planets = get_space_bodies.select{|body| body["isPlanet"] == true}
    end

    def get_list_of_moons
        moons = get_space_bodies.select{|body| body["aroundPlaner"] != {}}
    end

    def get_space_body_by_name(name)
        array_of_bodies = get_space_bodies.select{|body| body["englishName"] == name}
        # queries for a particular space object based on name parameter
    end
    def get_space_body_by_latin_name(name)
        array_of_bodies = get_space_bodies.select{|body| body["name"] == name}
        # queries for a particular space object based on name parameter
    end

    def add_planets
       get_list_of_planets.each {|planet| Planet.new(planet)}
    end

    def add_moons
        get_list_of_moons.each {|moon| Moon.new(moon)}
    end


 
end

# api = Api.new
