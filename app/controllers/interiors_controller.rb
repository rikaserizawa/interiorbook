class InteriorsController < ApplicationController
  before_action :require_user_logged_in ,only: [:create, :destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    #@interiors = Interior.search(params[:search])
    #@search = Interior.search(params[:q]) 
    #@interior = @search.result 
    if params[:q]
      @q = Interior.ransack(params[:q]) 
      @interiors  =  @q.result
    elsif params[:taste]
      @interiors = Interior.where(taste: params[:taste])
    elsif params[:room]
      @interiors = Interior.where(room: params[:room])
    end
  end
  
  def search
    index
    render :index
  end

  def create
    @interior = current_user.interiors.build(interior_params)
    if @interior.save!
      flash[:success] = 'Interiorを投稿しました。'
      redirect_to user_path(current_user)
    else
      @interiors = current_user.interiors.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Interiorの投稿に失敗しました。'
      render :show
    end
  end

  def destroy
    @interior.destroy
    flash[:success] = 'Interiorを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def show
    @interior = Interior.find(params[:id])
    @user = current_user
  end
  
  def edit
    @interior = Interior.find(params[:id])
  end
  
  def update
    @interior = Interior.find(params[:id])

    if @interior.update(interior_params)
      flash[:success] = 'Interiorは正常に更新されました'
      redirect_to @interior
    else
      flash.now[:danger] = 'Interiorは更新されませんでした'
      render :edit
    end
  end
  
  def scrap
    @scrap = current_user.interiors.build
  end

  private

  def interior_params
    params.require(:interior).permit(:title, :photo, :taste, :room, :appeal)
  end
  
  def correct_user
    @interior = current_user.interiors.find_by(id: params[:id])
    unless @interior
      redirect_to root_url
    end
  end
end