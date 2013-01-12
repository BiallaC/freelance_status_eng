class SessionsController < ApplicationController

	def new
		
	end

	def create
		freelancer = Freelancer.find_by_email(params[:session][:email].downcase)
		customer = Customer.find_by_email(params[:session][:email].downcase)
		if freelancer && freelancer.authenticate(params[:session][:password])
			log_in_freelancer freelancer
			redirect_to freelancer
		elsif customer && customer.authenticate(params[:session][:password])
			log_in_customer customer
			redirect_to customer
		else
			flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
		end
	end

	def destroy
		if loged_in_freelancer?
			log_out_freelancer
		elsif loged_in_customer?
			log_out_customer
		end
		redirect_to root_url
	end
end
