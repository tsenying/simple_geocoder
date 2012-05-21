require 'net/http'
require 'cgi'
require 'timeout'
require 'json'
require 'yaml'

# Geocoding is a time and resource intensive task. 
# Whenever possible, pre-geocode known addresses 
# (using the Geocoding API described here or another geocoding service), 
# and store your results in a temporary cache of your own design. (from Google Geocoding API docs)
module SimpleGeocoder
  class Geocoder
    @@api_config = YAML.load_file(File.join(File.dirname(__FILE__), '../../config/api.yml'))
    def initialize
      
    end

    # swallow exceptions and return nil on error
    def geocode(address)
      geocode!(address)
    rescue ResponseError
      nil
    end
    
    # raise ResponseError exception on error
    def geocode!(address)
      response = call_geocoder_service(address)
      if response.is_a?(Net::HTTPOK)
        return JSON.parse response.body
      else
        raise ResponseError.new response
      end
    end
    
    # if geocoding fails, then look for lat,lng string in address
    def find_location(address)
      result = geocode(address)
      if result['status'] == 'OK'
        return result['results'][0]['geometry']['location']
      else
        latlon_regexp = /(-?([1-8]?[0-9]\.{1}\d{1,6}|90\.{1}0{1,6})),(-?((([1]?[0-7][0-9]|[1-9]?[0-9])\.{1}\d{1,6})|[1]?[1-8][0]\.{1}0{1,6}))/
        if address =~ latlon_regexp
          location = $&.split(',').map {|e| e.to_f}
          return { "lat" => location[0], "lng" => location[1] }
        else
          return nil
        end
      end
    end
    
    private
    def call_geocoder_service(address)
      format = 'json'
      address = CGI.escape address
      parameters = "address=#{address}&region=#{@@api_config['google_v3']['region']}&sensor=#{@@api_config['google_v3']['sensor']}"
      url = "#{@@api_config['google_v3']['url_root']}/#{format}?#{parameters}"

      Net::HTTP.get_response(URI.parse(url))
    end
  end
end
