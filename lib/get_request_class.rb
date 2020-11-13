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

    def self.get_url(string, input)

        query = ""

        if string == "region" || string == "area"
            query = "a"
        elsif string == "category"
            query = "c"
        else
            query = "s"
        end
        "https://www.themealdb.com/api/json/v1/1/filter.php?#{query}=#{input}"
    end

end
