class FollowRelationshipsController < ApplicationController
  before_action :logged_in?
  def create
    FollowRelationship.create(follow_params)
    redirect_to user_mixes_path(User.find(params[:follow_relationship][:followed_id]))
  end

  def destroy
    FollowRelationship.find(params[:id]).destroy
    redirect_to user_mixes_path(User.find(params[:follow_relationship][:followed_id]))
  end

  private

  def follow_params
    params.require(:follow_relationship).permit(:follower_id, :followed_id)
  end
end
