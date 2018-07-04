class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  before_action :set_search_query
  def set_search_query
    @q = Interior.ransack(params[:q])
  end

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_scraps = user.scraps.count
    @count_interiors = user.interiors.count
  end
  
end
