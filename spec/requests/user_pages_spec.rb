require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  describe "profile page" do 
  	# creates a local instance variable and gets defined by the user created in spec/factories.rb file
  	let(:user) { FactoryGirl.create(:user) }
  	# This uses the user_path named route to generate the path to show the page for the given user
  	before { visit user_path(user) }

  	# Tests that the page content and title both contain th user's name
  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
  end

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_content('Sign Up') }
  	it { should have_title(full_title('Sign Up')) }
  end

  # Test validates the creation of a new user when the information is valid and not creating a user when it's invalid
  # The way to do this is to check the count of users, and under the hood our test will use the count method 
  describe "signup" do
  	before { visit signup_path }

  	# let creates a local instance variable named submit and assigns the string Create My Account to it
  	let(:submit) { "Create My Account" }

  	# Test is equivalent to visiting the signup page and submitting blank signup information (which is invalid)
  	describe "with invalid information" do
  	  it "should not create a user" do
  	  	# When submitting invalid data, we expect the user count not to change
  	  	expect { click_button submit }.not_to change(User, :count)
  	  end
  	end

  	# Test simulate the submission of valid data
  	describe "with valid information" do
  	  before do
  	  	fill_in "Name", 		with: "Example User"
  	  	fill_in "Email",		with: "user@example.com"
  	  	fill_in "Password",		with: "password"
  	  	fill_in "Confirmation",	with: "password"
  	  end

  	  it "should create a user" do
  	  	# When submitting valid data, we expect it to change by 1
  	  	expect { click_button submit }.to change(User, :count).by(1)
  	  end
  	end
  end
end