module LikesHelper
  def like_button(mix)
    if current_user && current_user.likes.any? {|like| like.mix_id == mix.id}
      button_to like_path(mix.likes.find_by(user_id: current_user.id)), method: :delete, class: "like-button" do
        "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-bookmark-heart-fill' viewBox='0 0 16 16'>
          <path d='M2 15.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v13.5zM8 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z'/>
        </svg>".html_safe
      end
    elsif current_user && !(current_user.likes.any? {|like| like.mix_id == mix.id})
      button_to likes_path(info: {mix_id: mix.id, user_id: current_user.id}), method: :post, class: "like-button" do
        "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-bookmark-heart' viewBox='0 0 16 16'>
          <path fill-rule='evenodd' d='M8 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z'/>
          <path d='M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z'/>
        </svg>".html_safe
      end
    else
      button_to '/login', method: :get, class: "like-button" do 
        "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-bookmark-heart' viewBox='0 0 16 16'>
          <path fill-rule='evenodd' d='M8 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z'/>
          <path d='M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z'/>
        </svg>".html_safe
      end
    end
  end
end
