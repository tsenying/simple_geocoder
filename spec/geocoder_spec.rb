require "spec_helper"

describe SimpleGeocoder::Geocoder do
  it "can geocode" do
    address = '2000 28th St, Boulder, CO'
    result = SimpleGeocoder::Geocoder.new.geocode(address)
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(40.018551)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-105.2582644)
  end
  
  it "works outside us region" do
    result =  SimpleGeocoder::Geocoder.new.geocode("Moto'otua, Samoa")
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(-13.8460556)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-171.7629788)
  end
  
  it "accepts region parameter" do
    # returns Toledo, Ohio location
    result =  SimpleGeocoder::Geocoder.new.geocode("Toledo")
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(41.6639383)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-83.555212)
    
    # returns Toledo, Spain location
    result =  SimpleGeocoder::Geocoder.new.geocode("Toledo",{:region=>'es'})
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(39.8567775)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-4.0244759)
  end
  
  it "accepts bounds parameter" do
    # returns Winnetka, IL location
    result =  SimpleGeocoder::Geocoder.new.geocode("Winnetka")
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(42.1080834)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-87.735895)
    
    # returns Winnetka, CA location
    result =  SimpleGeocoder::Geocoder.new.geocode("Winnetka", { :bounds => "34.172684,-118.604794|34.236144,-118.500938" } )
    result['status'].should == "OK" # at least one geocode returned
    result['results'][0]['geometry']['location']['lat'].should be_within(0.0001).of(34.20485860)
    result['results'][0]['geometry']['location']['lng'].should be_within(0.0001).of(-118.57396210)
  end
  
  it "can find lat/lng in string" do
    address = "ÜT: 34.044817,-118.311893"
    result = SimpleGeocoder::Geocoder.new.find_location(address)
    result.should_not be_nil
    result.should == {"lat"=> 34.044817,"lng"=> -118.311893}
  end
end