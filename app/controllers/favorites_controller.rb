class FavoritesController < ApplicationController
  def create
    @book = Book.find_by(id: params[:book_id])
    @favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    if @favorite.save
      render :favIndex
    end
  end

  def destroy
    @book = Book.find_by(id: params[:book_id])
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    if @favorite.delete
      render :favIndex
    end
  end

end
