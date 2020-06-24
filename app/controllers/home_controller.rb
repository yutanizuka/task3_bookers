class HomeController < ApplicationController
  def index
    @book = Book.new
    @user = User.find_by(params[:id])
    flash[:success] = "Welcome! You have signed up successfully." #homeの方に入れる
  end

  def about
    
  end
end
