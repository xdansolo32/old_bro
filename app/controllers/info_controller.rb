class InfoController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @broment = Broment.new if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def contact
  	@title = "Contact the Broverlords"
  end

  def about
  	@title = "Bro bio"
  end

end
