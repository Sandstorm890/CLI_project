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

    # def get_url(string, input)
    #     query_type = ""
        
    #     if string == "category"
    #         query_type = "c"
    #     elsif string == "region" || string == "area" 
    #         query_type = "a"
    #     else
    #         query_type = "i"
    #     end

    #     x = "https://www.themealdb.com/api/json/v1/1/filter.php?#{query_type}=#{input}"
    
    # end

end
