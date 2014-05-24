require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do

  	# description is just a string, and it can be anything you want; RSpec doesn't care
  	it "should have the content 'Movie App'" do
  		# visits the URL /static_pages/home
  		visit '/static_pages/home'
  		# express that expects the resulting page should have the right content
  		expect(page).to have_content('Movie Database App')
  	end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Aaron's Movie Database App | Home")
    end
  end

  describe "Help Page" do
  	
  	it "should have the content 'Help'" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  	end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Aaron's Movie Database App | Help")
    end
  end

  describe "About Me Page" do

  	it "should have the content 'About Me'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About Me')
  	end

    it "should have the title 'About Me'" do
      visit '/static_pages/about'
      expect(page).to have_title("Aaron's Movie Database App | About Me")
    end
  end
end
