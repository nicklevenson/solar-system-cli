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

end