module Accuweather
    class Forecast
        attr_accessor :temperature_min, :temperature_max, :weather_condition, :day_image_url, :night_image_url, :location_key

        def initialize(location_key)
            @location_key = location_key
        end

        def today_forecast
            begin
                result = get_today_forecast_details
                
                temperature_details = result.parsed_response["DailyForecasts"][0]["Temperature"]
                unit = temperature_details["Minimum"]["Unit"]
            
                @temperature_min = temperature_details["Minimum"]["Value"]
                @temperature_max = temperature_details["Maximum"]["Value"]
                @weather_condition = result.parsed_response["Headline"]["Text"]
            
                puts("-----------------------------------------")
                puts(@weather_condition)
                puts("Temperatura mínima: #{@temperature_min} #{unit}°")
                puts("Temperatura máxima: #{@temperature_max} #{unit}°")
                puts("-----------------------------------------")    
            rescue => exception
                puts("Deu ruim! -> #{exception}") 
            end
        end

        def get_today_forecast_details
            HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/#{@location_key}", params)
        end

        def params
            params = { query: { apikey: "fXMKOTLBD8BHkiRelYwDtJNguAVeTPPZ", language: "pt-BR" } }
        end
    end
end