module UsersHelper
  def profile_image(user)
    if user.avatar.attached?
      "<div class='profile-image'><img src='#{(url_for(user.avatar))}' class='rounded' width='120'></div>".html_safe
    else
      "<div class='profile-image'><img src='#{user.image}' class='rounded' width='120'></div>".html_safe
    end
  end

  def render_follow_form
    # if User.find(params[:user_id]).followed_by.include?(current_user)
    #   form_for current_user.follow_relationships.find_by(followed_id: params[:user_id]), method: :delete do |f|
    #     f.hidden_field :followed_id, value: params[:user_id]
    #     f.submit "Unfollow", class:"btn btn-sm btn-primary w-100 ml-2"
    #   end
    # else
    #   form_for FollowRelationship.new do |f|
    #     f.hidden_field :follower_id, value: current_user.id
    #     f.hidden_field :followed_id, value: params[:user_id]
    #     f.submit "Follow", class:"btn btn-sm btn-primary w-100 ml-2"
    #   end
    # end
  end
end
