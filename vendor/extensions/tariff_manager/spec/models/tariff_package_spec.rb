require File.dirname(__FILE__) + '/../spec_helper'

describe TariffPackage do
  before(:each) do
    @tariff_package = TariffPackage.new
  end

  it "should be valid" do
    @tariff_package.should be_valid
  end
end
