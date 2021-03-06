class ContentsController < ApplicationController
  before_action :logged_in?

  def show 
    @content = Content.find(params[:id])
    @mixes = @content.mixes
  end
  def destroy
    @mix = Mix.find(params[:mix_id])
    @mix.contents.delete(Content.find(params[:id]))
    redirect_to request.referrer
  end
end
