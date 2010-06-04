require File.dirname(__FILE__) + '/../spec_helper'

describe ProductVendor do
  before(:each) do
    @vendor_product = ProductVendor.new
  end

  it "should be valid" do
    @product_vendor.should be_valid
  end
end
