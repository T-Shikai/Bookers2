class CommentsController < ApplicationController
  before_action :ensure_correct_user, {only:[:destroy]}

  def ensure_correct_user
    if current_user.id != Comment.find(params[:id]).user_id && current_user.id != Book.find(params[:book_id]).user_id
      flash[:notice] = "The access is forbidden."
      redirect_to books_path
    end
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = params[:book_id]
    comment.save
    redirect_to book_path(params[:book_id])
  end

  def destroy
    Comment.find_by(id: params[:id], book_id: params[:book_id]).delete
    redirect_to book_path(params[:book_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
