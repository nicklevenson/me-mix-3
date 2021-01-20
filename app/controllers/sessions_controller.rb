class SessionsController < ApplicationController
  def new

  end

  def create

    @user = User.find_by(email: params[:email])
    if @user 
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:message] = "Incorrect Password"
        redirect_to '/login'
      end
    else
      flash[:message] = "Incorrect Email"
      redirect_to '/login'
    end
  end

  def omniauth
    @user = User.create_from_omniauth(auth)
  
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_mixes_path(@user)
    else
      flash[:message] = @user.errors.full_messages.join(", ")
      redirect_to '/login'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private 

  def auth
    request.env['omniauth.auth']
  end 
end
