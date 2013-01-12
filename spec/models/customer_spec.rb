require 'spec_helper'

describe Customer do

	before do
		@customer = Customer.new(name: "Example Customer", email: "customer@example.com", password: "foobar", password_confirmation: "foobar")
	end

	subject { @customer }

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:authenticate)}
	it {should respond_to(:remember_token)}

	it {should be_valid}

	describe "when name is not present" do
		before {@customer.name =" "}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before {@customer.email =" "}
		it {should_not be_valid}
	end

	describe "when email is not valid" do
	  it "should be invalid" do
	    addresses = %w[customer@foo,com customer_at_foo.org example.customer@foo.
	                   foo@bar_baz.com foo@bar+baz.com]
	    addresses.each do |invalid_address|
	      @customer.email = invalid_address
	      @customer.should_not be_valid
	    end
  	end
  end

  describe "when email is valid" do
  	it "should be valid" do
      addresses = %w[customer@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @customer.email = valid_address
        @customer.should be_valid
      end
    end
  end

  describe "when email is already taken" do
  	before do
  		customer_with_same_email = @customer.dup
  		customer_with_same_email.email = @customer.email.upcase
  		customer_with_same_email.save
  	end
  	it {should_not be_valid}
  end

  describe "when password is not present" do
  	before {@customer.password = @customer.password_confirmation = " "}
  	it {should_not be_valid}
  end

  describe "when password does not match confirmation" do
  	before {@customer.password_confirmation = "barfoo"}
  	it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
  	before {@customer.password_confirmation = nil}
  	it {should_not be_valid}
	end

	describe "when password is too short" do
		before {@customer.password = @customer.password_confirmation = "a"*5}
		it {should_not be_valid}
	end

	describe "return value of authenticate method" do
		before {@customer.save}
		let(:found_customer) {Customer.find_by_email(@customer.email)}

		# Customer-Object is equal to found_customer with authentication via valid password
		describe "with valid password" do
			it {should == found_customer.authenticate(@customer.password)}
		end

		describe "with invalid password" do
			let(:customer_with_invalid_password) {found_customer.authenticate("invalid")}

			it {should_not == customer_with_invalid_password}
			specify {customer_with_invalid_password.should be_false}
		end
	end
	describe "remember_token" do
		before {@customer.save}
		its(:remember_token) { should_not be_blank}
	end
end