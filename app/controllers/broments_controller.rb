class BromentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def index
  	
    @user = User.find(params[:user_id])
    #Uncomment below to show user's posts as /username
#     if params[:loginId]
#     	@user = User.where(:loginId => params[:loginId]).first
#     	@broments = @user.broments
#     else
#     	@broments = Broment.all
#     end
    @name = @user.name
    @broments = @user.broments
	@title = @user.name + "'s Broments"
	
  end
  
  def create
    @broment  = current_user.broments.build(params[:broment])
    if @broment.save
      flash[:success] = "Broment created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'info/home'
    end
  end

  def destroy
    @broment.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @broment = Broment.find(params[:id])
      redirect_to root_path unless current_user?(@broment.user)
    end
end