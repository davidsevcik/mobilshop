require File.dirname(__FILE__) + '/../spec_helper'

describe Operator do
  before(:each) do
    @operator = Operator.new
  end

  it "should be valid" do
    @operator.should be_valid
  end
end
