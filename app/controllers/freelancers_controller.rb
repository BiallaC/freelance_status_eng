class FreelancersController < ApplicationController
  def new
  	@freelancer = Freelancer.new
  end

  def create
  	@freelancer=Freelancer.new(params[:freelancer])
  	if @freelancer.save
      log_in_freelancer @freelancer
  		flash[:success] = "You are sucessfully registered! Welcome to Freelance Status"
  		redirect_to @freelancer
  	else
  		render 'new'
  	end
  end

  def show
  	@freelancer=Freelancer.find(params[:id])
  end
end
