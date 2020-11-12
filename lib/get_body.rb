require './config/environment.rb'

class GetRequest

    def initialize(url)
        @url = url.to_s
    end

    def get_response_body
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def response_json
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)
    end

    def self.all
        @@all
    end

end
