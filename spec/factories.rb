FactoryGirl.define do
	factory :freelancer do
		name "Example Freelancer"
		email "freelancer@example.com"
		password "foobar"
		password_confirmation "foobar"
		daily_rate 1000
	end

	factory :customer do
		name "Example Customer"
		email "customer@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end