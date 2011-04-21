class UsersController < ApplicationController
  
  def show 
    @user = User.find(params[:id])
    @title = @user.name + "'s profile"
  end
  
  def new
    @user = User.new
    @title = "Join the Revbrolution!"
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = "WhaduuUUUUUPPPPP! Welcome, bro."
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        @title = "Sign up"
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
