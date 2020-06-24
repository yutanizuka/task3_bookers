class BooksController < ApplicationController
  before_action :authenticate_user!,excepst: [:index] #deviseのメソッドで「ログインしていないユーザーをログイン画面に送る」メソッド
  def create
    @book = Book.new(book_params) #フォームから送られてきたデータ(body)をストロングパラメータを経由して@bookに代入
    @book.user_id = current_user.id #user_idの情報はフォームからきてないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    if @book.save
      redirect_to book_path(@book.id)
      # redirect_to books_path(params[:id])
      flash[:notice] = "You have creatad book successfully."
    else
      @books = Book.all
      @user = User.find_by(params[:id])
      flash.now[:notice] = "error prohibited this book from being saved:"
      render "books/index"
      # redirect_to books_path(params[:id])
    end
  end
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find_by(params[:id])
  end
  def show
    @user = User.find_by(params[:id])
    @book = Book.find(params[:id])
  end
  def edit
    @user = User.find_by(params[:id])
    @book = Book.find(params[:id])
  end 
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(params[:id])
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
private
  def book_params
    params.require(:book).permit(:title, :body,) # :user_id
  end
end
