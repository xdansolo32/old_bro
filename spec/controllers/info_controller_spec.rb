require 'spec_helper'

describe InfoController do
  render_views
  before(:each) do
    @base_title = "Welcome to Bromiscuous!"
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => @base_title)
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
      it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => @base_title +
                          " | Contact the Broverlords")
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
      it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => @base_title +
                          " | Bro bio")
    end
  end
  
end
