class WelcomeController < ApplicationController
  include WelcomeHelper
  # before_action :logged_in?
  def index
    @results = filter || []
    @last_selected = params[:filter]
  end
end

