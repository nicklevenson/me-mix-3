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

  def people_to_follow
    # if current_user
    # current_user_var = current_user
    # current_user.not_followed_yet.each do |user|
    #   render partial: 'users/user', locals: {user: user, current_user_var: current_user_var}
    # end
    # render partial: 'users/user', collection: current_user.not_followed_yet
    # else
    #   render partial: 'users/user', collection: User.sort_by_followers
    # end
  end
end
