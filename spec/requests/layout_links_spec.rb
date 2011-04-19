require 'spec_helper'

describe "LayoutLinks" do
  
  before(:each) do
    @base_title = "Welcome to Bromiscuous!"
  end
  
   it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => @base_title)
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact the Broverlords")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "Bro bio")
  end
  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Join the Revbrolution")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "Bro bio")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact the Broverlords")
    click_link "Home"
    response.should have_selector('title', :content => @base_title)
    click_link "Join the Revbrolution!"
    response.should have_selector('title', :content => "Join the Revbrolution")
  end
  
end
