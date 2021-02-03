class CommentsController < ApplicationController
  before_action :ensure_correct_user, {only:[:destroy]}

  def ensure_correct_user
    if current_user.id != Comment.find(params[:id]).user_id && current_user.id != Book.find(params[:book_id]).user_id
      flash[:notice] = "The access is forbidden."
      redirect_to books_path
    end
  end

  def create
    @book = Book.find(params[:book_id])
    @comments = Comment.where(book_id: params[:book_id])
    @comment = Comment.new
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = params[:book_id]
    if comment.save
      render :index
    end

  end

  def destroy
    @book = Book.find(params[:book_id])
    @comments = Comment.where(book_id: params[:book_id])
    @comment = Comment.new
    comment = Comment.find_by(id: params[:id], book_id: params[:book_id])
    if comment.delete
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
