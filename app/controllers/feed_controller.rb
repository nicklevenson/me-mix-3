class FeedController < ApplicationController
  def index
    @mixes = current_user.feed 
  end
end
