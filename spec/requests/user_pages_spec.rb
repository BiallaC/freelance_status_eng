require 'spec_helper'

describe "Freelancer pages" do

  subject { page }

  describe "profile page" do
    let(:freelancer) {FactoryGirl.create(:freelancer)}
    before { visit freelancer_path(freelancer)}

    it { should have_selector('h1',    text: freelancer.name) }
    it { should have_selector('title', text: freelancer.name) }
  end

  describe "signup" do
  	before {visit signup_freelancer_path}

  	let(:submit) {"Create my account"}

	  describe "with invalid information" do
	  	it "should not create a freelancer" do
	  		expect {click_button submit}.not_to change(Freelancer, :count)
	  	end
	  end

	  describe "with valid information" do
	  	before do
	  		fill_in "Name", with: "Example Freelancer"
	  		fill_in "Email", with: "freelancer@example.com"
	  		fill_in "Password", with: "foobar"
	  		fill_in "Password confirmation", with: "foobar"
	  	end

	  	it "should create a freelancer" do
	  		expect {click_button submit}.to change(Freelancer, :count).by(1)
	  	end
	  end
  end
end
