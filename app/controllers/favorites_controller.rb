class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to :back （rails 5.1からは使用不可）
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    # favorite = current_user.favorites.find_by(book_id: @book.id) #他人のbookidの場合エラー
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
