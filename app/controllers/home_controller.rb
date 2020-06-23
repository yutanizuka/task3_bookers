class HomeController < ApplicationController
  def home
    flash[:success] = "Welcome! You have signed up successfully." #homeの方に入れる
  end

  def about
    
  end
end
