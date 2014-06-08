FactoryGirl.define do
  # By passing the symbol :user to the factory command, we tell Factory Girl that the subsequent definition is for a User model object
  # This method allows us to create user for testing in RSpec (user_pages_spec.rb)
  factory :user do
  	name	 "Aaron Carlson"
  	email	 "acarlson90@gmail.com"
  	password "password"
  	password_confirmation "password"
  end
end