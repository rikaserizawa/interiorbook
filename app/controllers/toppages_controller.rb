class ToppagesController < ApplicationController
  def index
    @interiors = Interior.order('created_at DESC').page(params[:page])
  end
end
