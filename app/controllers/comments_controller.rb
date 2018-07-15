class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @interior = Interior.find(params[:comment][:interior_id])
    @comment = current_user.comments.build(comment_params)
    @comments = @interior.comments.order('created_at DESC').page(params[:page])
    
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to interior_path(@interior)
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render "interiors/show"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_to  request.referrer || root_url
  end
  

  private

  def comment_params
    params.require(:comment).permit(:user_id, :interior_id, :body)
  end

end