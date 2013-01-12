module SessionsHelper

	#------------------- Code for Freelancer -------------------#
	def log_in_freelancer(freelancer)
		cookies.permanent[:remember_token] = freelancer.remember_token
		self.current_freelancer = freelancer
	end

	def loged_in_freelancer?
		!current_freelancer.nil?
	end

	def current_freelancer= (freelancer)
		@current_freelancer = freelancer
	end

	def current_freelancer
		@current_freelancer ||= Freelancer.find_by_remember_token(cookies[:remember_token])
	end

	def log_out_freelancer
		self.current_freelancer = nil
		cookies.delete(:remember_token)
	end

	#------------------- Code for Customer -------------------#
	def log_in_customer(customer)
		cookies.permanent[:remember_token] = customer.remember_token
		self.current_customer = customer
	end

	def loged_in_customer?
		!current_customer.nil?
	end

	def current_customer= (customer)
		@current_customer = customer
	end

	def current_customer
		@current_customer ||= Customer.find_by_remember_token(cookies[:remember_token])
	end

	def log_out_customer
		self.current_customer = nil
		cookies.delete(:remember_token)
	end
end
