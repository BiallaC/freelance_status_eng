require 'spec_helper'

describe "Authentication Freelancer" do

	subject { page }

	describe "login page" do
		before {visit login_path}

	  it {should have_selector('h1', text:'Log In')}
	  it {should have_selector('title', text:'Log In')}
	end

	describe "login" do
		before {visit login_path}
			
		describe "with invalid information" do
		  before { click_button "Log In"}

		  it {should have_selector('title', text: 'Log In')}
		  it {should have_selector('div.alert.alert-error', text: 'Invalid')}

		  describe "after visiting another page" do
		  	before { click_link "Home"}
		  	it{should_not have_selector('div.alert.alert-error')}
		  end
		end

		describe "with valid information" do
		  let(:freelancer) {FactoryGirl.create(:freelancer)}
		  before do
		  	fill_in "Email", with: freelancer.email
		  	fill_in "Password", with: freelancer.password
		  	click_button "Log In"
		  end

		  it {should have_selector('title', text: freelancer.name)}
		  it {should have_link('Profile', href: freelancer_path(freelancer))}
		  it {should have_link('Log Out', href: logout_path)}
		  it {should_not have_link('Log In', href: login_path)}

		  describe "followed by logout" do
				before {click_link "Log Out"}
				it {should have_link('Log In')}
			end
		end  
	end
end
