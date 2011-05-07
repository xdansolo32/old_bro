class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :signed_in_user, :only => [:new, :create]

  
  def index
    @title = "Fellow Bros"
    @users = User.search(params[:search], params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    # Uncomment next part to do something like /username isntead of /users/1
    # if params[:loginId]
#     	@user = User.where(:loginId => params[:loginId]).first
#     	@broments = @user.broments
#     else
#     	@broments = Broment.all
#     end
    @broments = @user.broments.paginate(:page => params[:page])
    @title = @user.name + "'s Brofile"
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
    @title = "Edit brofile"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Brofile updated."
      redirect_to @user
    else
      @title = "Edit brofile"
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
