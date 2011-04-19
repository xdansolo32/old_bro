class UsersController < ApplicationController
  
  def show 
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @title = "Join the Revbrolution!"
  end

end
