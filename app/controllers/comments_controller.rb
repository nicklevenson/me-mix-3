class CommentsController < ApplicationController
  before_action :logged_in?
  def create
    if current_user
      comment = Comment.new(comment_params)
      comment.user_id = current_user.id
      comment.save
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
  end
  private

  def comment_params
    params.require(:comment).permit(:mix_id, :content)
  end

end
