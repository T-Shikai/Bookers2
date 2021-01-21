class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    @favorite.save
    redirect_to book_path(params[:book_id])
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.delete
    redirect_to book_path(params[:book_id])
  end

end
