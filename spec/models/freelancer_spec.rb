require 'spec_helper'

describe Freelancer do

	before do
		@freelancer = Freelancer.new(name: "Example Freelancer", email: "freelancer@example.com", password: "foobar", password_confirmation: "foobar", status: "available", daily_rate: 1000)
	end

	subject { @freelancer }

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:authenticate)}
	it {should respond_to(:remember_token)}
	it {should respond_to(:status)}
	it {should respond_to(:daily_rate)}

	it {should be_valid}

	describe "when name is not present" do
		before {@freelancer.name =" "}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before {@freelancer.email =" "}
		it {should_not be_valid}
	end

	describe "when email is not valid" do
	  it "should be invalid" do
	    addresses = %w[freelancer@foo,com freelancer_at_foo.org example.freelancer@foo.
	                   foo@bar_baz.com foo@bar+baz.com]
	    addresses.each do |invalid_address|
	      @freelancer.email = invalid_address
	      @freelancer.should_not be_valid
	    end
  	end
  end

  describe "when email is valid" do
  	it "should be valid" do
      addresses = %w[freelancer@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @freelancer.email = valid_address
        @freelancer.should be_valid
      end
    end
  end

  describe "when email is already taken" do
  	before do
  		freelancer_with_same_email = @freelancer.dup
  		freelancer_with_same_email.email = @freelancer.email.upcase
  		freelancer_with_same_email.save
  	end
  	it {should_not be_valid}
  end

  describe "when password is not present" do
  	before {@freelancer.password = @freelancer.password_confirmation = " "}
  	it {should_not be_valid}
  end

  describe "when password does not match confirmation" do
  	before {@freelancer.password_confirmation = "barfoo"}
  	it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
  	before {@freelancer.password_confirmation = nil}
  	it {should_not be_valid}
	end

	describe "when password is too short" do
		before {@freelancer.password = @freelancer.password_confirmation = "a"*5}
		it {should_not be_valid}
	end

	describe "when daily rate is not an integer" do
		before {@freelancer.daily_rate = "1.000"}
		it {should_not be_valid}
	end

	describe "return value of authenticate method" do
		before {@freelancer.save}
		let(:found_freelancer) {Freelancer.find_by_email(@freelancer.email)}

		# Freelancer-Object is equal to found_freelancer with authentication via valid password
		describe "with valid password" do
			it {should == found_freelancer.authenticate(@freelancer.password)}
		end

		describe "with invalid password" do
			let(:freelancer_with_invalid_password) {found_freelancer.authenticate("invalid")}

			it {should_not == freelancer_with_invalid_password}
			specify {freelancer_with_invalid_password.should be_false}
		end
	end
	describe "remember_token" do
		before {@freelancer.save}
		its(:remember_token) { should_not be_blank}
	end
end