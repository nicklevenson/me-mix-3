module LikesHelper
  def like_button(mix)
    if current_user && current_user.likes.any? {|like| like.mix_id == mix.id}
      button_to "Unlike", like_path(mix.likes.find_by(user_id: current_user.id)), method: :delete 
    elsif current_user && !(current_user.likes.any? {|like| like.mix_id == mix.id})
      button_to "Like Mix", likes_path(info: {mix_id: mix.id, user_id: current_user.id}), method: :post
    else
      button_to "Like Mix", '/login', method: :get
    end
  end
end
