class PageController < ApplicationController
  def home
  	if current_user 
        redirect_to books_path
     end
  end
end
