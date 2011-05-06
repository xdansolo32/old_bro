class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :signed_in_user, :only => [:new, :create]

  
  def index
    @title = "Fellow Bros"
    @users = User.paginate(:page => params[:page])
  end
  
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
  
  def edit
    #@user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Brofile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if(!@user.admin?)
    	User.find(params[:id]).destroy
    	flash[:success] = "User destroyed."
    	redirect_to users_path
    else
    	flash[:error] = "Say no to suicide."
    	redirect_to users_path
    end
  end
  
  def show
    @user = User.find(params[:id])
    @broments = @user.broments.paginate(:page => params[:page])
    @title = "Proof that " +  @user.name + " is a total bro"
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def signed_in_user
      redirect_to(root_path) if signed_in?
    end

end
