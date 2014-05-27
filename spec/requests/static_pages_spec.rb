require 'spec_helper'

describe "Static Pages" do

  # tells RSpec that page is subjec of the tests
  subject { page }

  describe "Home Page" do
    # visit the root path before each example (The before method can also be invoked with before(:each), which is a synonym)
    before { visit root_path }

    # Using a variant of the it method to collapse the code and description into one line
    # Because of subject { page }, the call to should automatically use the page variable supplied by Capybara
    it { should have_content('Movie Database App') }
    # Uses the full title function in /spec/support/utilities.rb
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help Page" do
    before { visit help_path }
  	
    it { should have_content('Help') }
    it { should have_title(full_title('')) }
  end

  describe "About Me Page" do
    before { visit about_path }

    it { should have_content('About Me') }
    it { should have_title(full_title('')) }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('')) }
  end
end
