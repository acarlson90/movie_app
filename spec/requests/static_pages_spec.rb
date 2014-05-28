require 'spec_helper'

describe "Static Pages" do

  # tells RSpec that page is subjec of the tests
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    # Uses the full title function in /spec/support/utilities.rb
    it { should have_title(full_title(page_title)) }
  end

  describe "Home Page" do
    # visit the root path before each example (The before method can also be invoked with before(:each), which is a synonym)
    before { visit root_path }
    let(:heading)     { 'Movie Database App' }
    let(:page_title)  { '' }

    it_should_behave_like "all static pages"
    # Using a variant of the it method to collapse the code and description into one line
    # Because of subject { page }, the call to should automatically use the page variable supplied by Capybara
    it { should_not have_title('| Home') }
  end

  describe "Help Page" do
    before { visit help_path }
    
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About Me Page" do
    before { visit about_path }

    let(:heading)     { 'About Me' }
    let(:page_title)  { 'About Me' }

    it_should_behave_like "all static pages"
  end

  describe "Contact Page" do
    before { visit contact_path }

    let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Me'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign Up Now!"
    expect(page).to have_title('Sign Up')
    click_link "movie app"
    expect(page).to have_title('Movie Database App')
  end
end