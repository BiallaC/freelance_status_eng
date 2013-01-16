include ApplicationHelper

def valid_signin(freelancer)
  fill_in "Email",    with: freelancer.email
  fill_in "Password", with: freelancer.password
  click_button "Log In"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

def log_in(freelancer)
  visit login_path
  fill_in "Email",    with: freelancer.email
  fill_in "Password", with: freelancer.password
  click_button "Log In"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = freelancer.remember_token
end