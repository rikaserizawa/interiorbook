class ScrapsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    interior = Interior.find(params[:interior_id])
    interior.fav(current_user)
    flash[:success] = 'Scrapに追加しました。'
    redirect_to current_user
  end

  def destroy
    interior = Interior.find(params[:interior_id])
    interior.unfav(current_user)
    flash[:success] = 'Scrapをはずしました。'
    redirect_to current_user
  end
end
