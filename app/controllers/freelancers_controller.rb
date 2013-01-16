class FreelancersController < ApplicationController

  before_filter :loged_in_freelancer, only: [:edit, :update]
  before_filter :correct_freelancer, only: [:edit, :update]

  def new
  	@freelancer = Freelancer.new
  end

  def create
  	@freelancer=Freelancer.new(params[:freelancer])
  	if @freelancer.save
      log_in_freelancer @freelancer
  		flash[:success] = "You are sucessfully registered! Welcome to Freelance Status"
  		redirect_to edit_freelancer_path(@freelancer)
  	else
  		render 'new'
  	end
  end

  def show
  	@freelancer=Freelancer.find(params[:id])
  end

  def edit
    @freelancer=Freelancer.find(params[:id])
  end

  def update
    @freelancer=Freelancer.find(params[:id])
    if @freelancer.update_attributes(params[:freelancer])
      flash[:success] = "Your profile was successfully updated!"
      log_in_freelancer @freelancer
      redirect_to @freelancer
    else
      render 'edit'
    end
  end

  private

    def loged_in_freelancer
      redirect_to login_url, notice: "Please sign in." unless loged_in_freelancer?
    end

    def correct_freelancer
      @freelancer = Freelancer.find(params[:id])
      redirect_to(root_path) unless current_freelancer?(@freelancer)
    end

end
