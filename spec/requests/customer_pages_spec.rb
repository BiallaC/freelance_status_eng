require 'spec_helper'

describe "Customer pages" do

  subject { page }

  describe "profile page" do
    let(:customer) {FactoryGirl.create(:customer)}
    before { visit customer_path(customer)}

    it { should have_selector('h1',    text: customer.name) }
    it { should have_selector('title', text: customer.name) }
  end

  describe "signup" do
  	before {visit signup_customer_path}

  	let(:submit) {"Create my account"}

	  describe "with invalid information" do
	  	it "should not create a customer" do
	  		expect {click_button submit}.not_to change(Customer, :count)
	  	end
	  end

	  describe "with valid information" do
	  	before do
	  		fill_in "Name", with: "Example Customer"
	  		fill_in "Email", with: "customer@example.com"
	  		fill_in "Password", with: "foobar"
	  		fill_in "Password confirmation", with: "foobar"
	  	end

	  	it "should create a customer" do
	  		expect {click_button submit}.to change(Customer, :count).by(1)
	  	end
	  end
  end
end
