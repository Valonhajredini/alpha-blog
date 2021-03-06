class UsersController < ApplicationController
  before_action :set_user ,only: [ :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user= User.new

  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]= @user.id
      flash[:success] = "Welcome to alpha block #{@user.username}"
      redirect_to user_path(@user.id)

    else
      flash[:danger] = ""
      render 'new'
    end

  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    if @user.update(user_params)
      flash[:success] = "Your acount wos updated successfully"
      redirect_to edit_user_path(@user)
    else
      render "new"
    end
  end
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by #{@user.username} have been deleted"
    redirect_to users_path
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only your own acount"
      redirect_to root_path
    end
  end
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform thet action!!!"
      redirect_to root_path
    end

  end


end