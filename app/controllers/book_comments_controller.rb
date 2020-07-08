class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    book = Book.find(params[:book_id])
    comment = book.book_comments.new(book_comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "Comment was successfully created."
      # redirect_back(fallback_location: root_path)
      redirect_to request.referer
    else
      @book = Book.new
      @book_comments = @book.book_comments
      render '/books/show'
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    #bookcommentコントローラーからidとbookidが一致するものを削除する？

    redirect_to book_path(params[:book_id])
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
