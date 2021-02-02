class UsersController < ApplicationController
  before_action :ensure_correct_user, {only:[:edit, :update]}



  def ensure_correct_user
    if current_user != User.find(params[:id])
      flash[:notice] = "The access is forbidden."
      redirect_to user_path(current_user.id)
    end
  end



  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id]).page(params[:page]).reverse_order.per(7)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.all
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end