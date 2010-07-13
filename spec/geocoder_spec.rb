require "spec_helper"

describe SimpleGeocoder::Geocoder do
  it "can geocode" do
    address = '2000 28th St, Boulder, CO'
    SimpleGeocoder::Geocoder.new.geocode(address).should == "40,-102"
  end
end