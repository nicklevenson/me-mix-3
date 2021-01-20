module FeedHelper
  def no_feed 
    if @mixes.empty? 
      content_tag :h1, "This is where you'll see mixes by people you have followed. So go follow some people!" 
      render partial: 'users/user', collection: User.all
    end
  end
end
