class UsersController < ApplicationController
  before_action :authenticate_user!
  layout "application",except: [:edit]
  def index
    @users = User.all.order(created_at: :desc) #indexページに一覧表示用
    @book = Book.new
  end
  def show
    @book = Book.new #サイドページ投稿用
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
  end
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id #@user単体ではダメ
      redirect_to "/users/#{current_user.id}"
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :"users/edit"
    end
  end
  private 
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
