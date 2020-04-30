module Accuweather
    class Location
        include HTTParty

        attr_accessor :city
        
        def initialize(city)
            @city = city
        end

        def key
            begin
                get_location_details.parsed_response[0]["Key"]
            rescue => exception
                puts("Deu ruim -> #{exception}")
            end
        end

        def get_location_details
            HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/search", params)
        end

        def params
            params = { query: { apikey: "fXMKOTLBD8BHkiRelYwDtJNguAVeTPPZ", language: "pt-BR", q: @city } }
        end
    end
end