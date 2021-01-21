class UsersController < ApplicationController
  before_action :access_user, only: [:edit, :update]
  before_action :get_user, only: [:show, :edit, :update, :following, :followers]
  layout 'login', except: [:edit, :following, :followers]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_mixes_path(@user)
    else
      render :new
    end
  end

  def show
    params.inspect
    redirect_to user_mixes_path(@user)
  end

  def edit 
  
  end

  def update
    if @user.update(user_params)
      redirect_to user_mixes_path(@user)
    else
      render :edit
    end
  end

  def following
    @users = @user.followed_users
  end

  def followers
    @users = @user.followed_by
  end
  private

  def access_user
    return head(:forbidden) unless get_user == current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end

  def get_user
    @user = User.find(params[:user_id])
  end
end
