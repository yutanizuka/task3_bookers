class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    # @books = Book.page(params[:page]).reverse_order
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(params[:id])
  end

  private 
  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end
end
