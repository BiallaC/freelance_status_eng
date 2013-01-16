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
		  
		  before { log_in freelancer }

		  it {should have_selector('title', text: freelancer.name)}
		  it {should have_link('Profile', href: freelancer_path(freelancer))}
		  it {should have_link('Log Out', href: logout_path)}
		  it {should have_link('Settings', href: edit_freelancer_path(freelancer))}
		  it {should_not have_link('Log In', href: login_path)}


		  describe "followed by logout" do
				before {click_link "Log Out"}
				it {should have_link('Log In')}
			end
		end  

		describe "authorization" do
			
			describe "for non-signed-in freelancer" do
				let(:freelancer) {FactoryGirl.create(:freelancer)}

				describe "in the Freelancers controller" do

					describe "visiting the edit page" do
						before {visit edit_freelancer_path(freelancer)}
						it { should have_selector('title', text: "Log In")}
					end

					describe "submitting to the update action" do
						before { put freelancer_path(freelancer)}
						specify { response.should redirect_to(login_path)}
					end
				end
			end

			describe "as wrong freelancer" do
				let(:freelancer) {FactoryGirl.create(:freelancer)}
				let(:wrong_freelancer) {FactoryGirl.create(:freelancer, email:"wrong@example.com")}
				before { log_in freelancer}

				describe "visiting Freelancer#edit page" do
					before {visit edit_freelancer_path(wrong_freelancer)}
					it {should_not have_selector('title', text: full_title('Edit freelancer'))}
				end

				describe "submitting a PUT request to the Freelancer#update action" do
					before {put freelancer_path(wrong_freelancer)}
					specify {response.should redirect_to(root_path)}
				end					
			end
		end
	end
end
