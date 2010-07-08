require File.dirname(__FILE__) + '/../spec_helper'

describe OrderInfo do
  before(:each) do
    @contact = OrderInfo.new
  end

  it "should be valid" do
    @contact.should be_valid
  end
end
