require File.dirname(__FILE__) + '/../spec_helper'

describe Tariff do
  before(:each) do
    @tariff = Tariff.new
  end

  it "should be valid" do
    @tariff.should be_valid
  end
end
