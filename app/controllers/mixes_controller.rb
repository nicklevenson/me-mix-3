class MixesController < ApplicationController
  include MixesHelper
  before_action :logged_in?

  def index
    @user = User.find(params[:user_id])
    @mixes = @user.mixes
    @current_user = current_user
  end

  def new
    @mix = Mix.new
  end

  def create
    @mix = current_user.mixes.find_or_create_by(mix_params)
    @mix.description = params[:mix][:description] unless params[:mix][:description].blank?
    
    if @mix.save
      if params[:content]
        content =  Content.find_or_create_by(content_params)
        @mix.contents <<  content unless @mix.contents.include?(content)
      else
        redirect_to user_mix_path(current_user, @mix)
      end
    else
      render :new
    end
    
  end

  def show
    @mix = Mix.find(params[:id])
  end

  def edit
    @mix = Mix.find(params[:id])
  end

  def update
    @mix = Mix.find(params[:id])
    if @mix.update(mix_update_params)
      redirect_to user_mix_path(current_user, @mix)
    else
      render :edit
    end
  end

  def destroy
    @mix = Mix.find(params[:id])
    @mix.destroy
    redirect_to user_mixes_path(current_user)
  end

  private

  def mix_params
    params.require(:mix).permit(:title)
  end

  def content_params
    params.require(:content).permit(:data_type, :title, {creators: []}, :date, :image, :url, :description)
  end

  def mix_update_params
    params.require(:mix).permit(:title, :description, notes_attributes: [:text, :content_id, :id])
  end
end
