class BooksController < ApplicationController
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}

  def ensure_correct_user
    if current_user.id != Book.find(params[:id]).user_id
      flash[:notice] = "The access is forbidden."
      redirect_to books_path
    end
  end

  def index
    @books = Book.page(params[:page]).reverse_order.per(7)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.page(params[:page]).reverse_order.per(7)
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    @comment = Comment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    flash[:notice] = "you have deleted #{book.title} successfully."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end



end
