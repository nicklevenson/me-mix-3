class FeedController < ApplicationController
  before_action :logged_in?
  def index
    # if current_user
      @mixes = current_user.feed
      @current_user = current_user
    # else
    #   @mixes = Mix.most_recent
    # end
    
  end
end
