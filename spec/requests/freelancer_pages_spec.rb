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

	  	describe "after saving the freelancer" do
        before { click_button submit }
        let(:freelancer) { Freelancer.find_by_email('freelancer@example.com') }

        it { should have_selector('title', text: "Edit freelancer") }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Log Out') }
      end
	  end
  end

  describe "edit" do
  	let(:freelancer){FactoryGirl.create(:freelancer)}
  	before do
      log_in freelancer
      visit edit_freelancer_path(freelancer)
    end

  	describe "page" do
  		it {should have_selector('h1', text: "Edit your profile")}
  		it {should have_selector('title', text: "Edit freelancer")}
  		it {should have_link('change', href:'http://gravatar.com/emails')}
  	end

  	describe "with invalid information" do
  		before do
        fill_in "freelancer_daily_rate", with: "ABC"
        click_button "Save changes"
      end

  		it {should have_content('error')}
    end

    describe "with valid information" do
      let(:new_daily_rate) {1000}
      before do
        fill_in "Daily rate", with: new_daily_rate
        click_button "Save changes"
      end
      
      it { should have_content('Daily rate: 1000')}
      it { should have_selector('div.alert.alert-success')}
      it { should have_link('Log Out', href:logout_path)}

      specify { freelancer.reload.daily_rate.should == new_daily_rate}

    end

  end
end
