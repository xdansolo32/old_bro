class InfoController < ApplicationController
  def home
  end

  def contact
  	@title = "Contact the Broverlords"
  end

  def about
  	@title = "Bro bio"
  end

end
