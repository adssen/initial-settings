class TransactionsController< ApplicationController
	def create
		book = Book.find_by!(slug: params[:slug])
		
		sale = book.sales.create(
			amount: book.price, 
			buyer_email: current_user.email, 
			seller_email: book.user.email, 
			stripe_token: params[:stripeToken])
		sale.process!
		if sale.finished?
			redirect_to pickup_url(guid: sale.guid), notice: "YoYoYo~ Transaction Successful"
		else 
			redirect_to book_path(book), notice: "Well....Something went wrong"
		end
	end

	def pickup
		@sale = Sale.find_by!(guid: params[:guid])
		@book = @sale.book
	end
end