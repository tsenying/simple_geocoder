require "spec_helper"

describe SimpleGeocoder::Geocoder do
  it "can geocode" do
    address = '2000 28th St, Boulder, CO'
    result = SimpleGeocoder::Geocoder.new.geocode(address)
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_close(40.0185510, 0.0001)
    result['results'][0]['geometry']['location']['lng'].should be_close(-105.2582644, 0.0001)
  end
  
  it "can find lat/lng in string" do
    address = "ÜT: 34.044817,-118.311893"
    result = SimpleGeocoder::Geocoder.new.find_location(address)
    result.should_not be_nil
    result.should == {"lat"=> 34.044817,"lng"=> -118.311893}
  end
end