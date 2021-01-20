class FeedController < ApplicationController
  before_action :logged_in?
  def index
    @mixes = current_user.feed 
  end
end
