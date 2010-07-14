require "spec_helper"

describe SimpleGeocoder::Geocoder do
  it "can geocode" do
    address = '2000 28th St, Boulder, CO'
    result = SimpleGeocoder::Geocoder.new.geocode(address)
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location'].should == {"lat"=> 40.0185510,"lng"=> -105.2582644}
  end
end