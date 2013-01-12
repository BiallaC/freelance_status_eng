class CustomersController < ApplicationController
  def new
  	@customer = Customer.new
  end

	def create
  	@customer = Customer.new(params[:customer])
  	if @customer.save
  		flash[:sucess] = "You are sucessfully registered! Welcome to Freelance Status"
  		redirect_to @customer
  	else
  		render 'new'
  	end
	end

  def show
  	@customer = Customer.find(params[:id])
  end
end
