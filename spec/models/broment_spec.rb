require 'spec_helper'

describe Broment do
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content"}
  end

  it "should create a new instance given valid attributes" do
    @user.broments.create!(@attr)
  end
  
  describe "user associations" do

    before(:each) do
      @broment = @user.broments.create(@attr)
    end

    it "should have a user attribute" do
      @broment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @broment.user_id.should == @user.id
      @broment.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Broment.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.broments.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.broments.build(:content => "a" * 141).should_not be_valid
    end
  end
end
