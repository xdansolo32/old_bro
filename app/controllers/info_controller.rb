class InfoController < ApplicationController
  def home
  	@title = "Welcome to Bromiscuous!"
  end

  def contact
  	@title = "Contact the Broverlords"
  end

  def about
  	@title = "Bro bio"
  end

end
