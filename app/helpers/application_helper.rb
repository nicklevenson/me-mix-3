module ApplicationHelper
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  
  def logged_in? 
    if current_user
      true
    else
      redirect_to '/login'
    end
  end
end
