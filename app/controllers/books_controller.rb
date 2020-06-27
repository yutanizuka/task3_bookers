class BooksController < ApplicationController
  before_action :authenticate_user!,excepst: [:index] #deviseのメソッドで「ログインしていないユーザーをログイン画面に送る」メソッド
  def create
    @book = Book.new(book_params) #フォームから送られてきたデータ(body)をストロングパラメータを経由して@bookに代入
    @book.user_id = current_user.id #user_idの情報はフォームからきてないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have creatad book successfully."
    else
      @books = Book.all
      @user = User.find_by(params[:id])
      flash.now[:danger] = "error prohibited this book from being saved:"
     render "books/index"
    end
  end
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id
      redirect_to action: :index
    end
  end 
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have update book successfully."
      redirect_to book_path(params[:id])
    else
      @user = current_user
      render :"books/edit"
    end
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
    params.require(:book).permit(:title, :body)
  end
end
