class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :confirm]
  before_action :correct_user, only: [:destroy, :edit, :update, :confirm]
  
  #mybookのページ
  def show 
    @user = User.find(params[:id])
    #@user = current_user
    @interior = current_user.interiors.build  # form_for 用
    @interiors = @user.interiors.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = 'ユーザー登録を削除しました。ご利用ありがとうございました。'
    redirect_back(fallback_location: root_path)
  end  

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Userプロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'Userプロフィールは更新されませんでした'
      render :edit
    end
  end
  
  #お気に入り
  def scraps
    @user = User.find(params[:id])
    @scraps = @user.scraps.page(params[:page])
    @interior = current_user.interiors.build  # form_for 用
    counts(@user)
  end
  
  #ユーザー削除のページ
  def confirm
    @user = User.find(params[:id])
  end
  
  def help
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
  
end
