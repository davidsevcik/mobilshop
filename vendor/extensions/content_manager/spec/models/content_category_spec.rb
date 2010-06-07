require File.dirname(__FILE__) + '/../spec_helper'

describe ContentCategory do
  before(:each) do
    @content_category = ContentCategory.new
  end

  it "should be valid" do
    @content_category.should be_valid
  end
end
