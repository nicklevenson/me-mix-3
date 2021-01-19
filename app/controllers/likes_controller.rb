class LikesController < ApplicationController
  before_action :logged_in?
  def create
    params.inspect
    Like.create(like_params)
    redirect_to params[:info][:lasturl]
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to params[:info][:lasturl]
  end

  private

  def like_params
    params.require(:info).permit(:mix_id, :user_id)
  end
end
