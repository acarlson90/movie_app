require 'spec_helper'

describe User do
  # The block runs the code inside the bloc before each example - in this case, creating a new @user instance variable using User.new and a valid initialization hash
  before do 
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  # Makes @user the default subject of the test example
  subject { @user }

  # The examples test for the existence of name and email attributes
  # Ensure that the constructions user.name and user.email are valid, whereas the before block only tests the attributes when passed as a hash to new
  it { should respond_to(:name) }
  # The respond_to methods implicitly uses the Ruby method respond_to?, which accepts a symbol and returns true if the object responds to the given method or attribute and false otherwise
  it { should respond_to(:email) }
  # User object should respond to password_digest
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  # Verifying that the subject (@user) is initially valid
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid}
  end

  describe "when email format is invalid" do
  	it "should be valid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			expect(@user).not_to be_valid
  		end
  	end
  end

  # Check the common valid email formats user@foo.COM, THE_US-ER@foo.bar.org (uppercase, underscores, and compound domains), and first.last@foo.jp (the standard corporate username first.last, with a two-letter top-level domain jp (Japan))
  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			expect(@user).to be_valid
  		end
  	end
  end

  # The method here is to make a user with the same email address as @user, which we accomplish using @user.dup, which creates a duplicate user with the same attributes
  # Since we then save that user, the orginial @user has an email address that already exits in the database, and hence should not be valid
  describe "when email address is already taken" do
    before do
      	user_with_same_email = @user.dup
      	user_with_same_email.email = @user.email.upcase
      	user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # We make sure to test the presence validation by setting both the password and its confirmation to a blank string
  # Test pass because of the has_secure_password
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  # Want to ensure that the password and confirmation match. The case where they do match is already covered by it { should be_valid }, so we only need to test the case of a mismatch
  # Test pass because of the has_secure_password
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  # Test for a length validation on passwords, requiring that they be at least six characters long
  # Note: let memoizes its value, so that the first nested describe block invokes let to retrieve the user from the database using find_by, but the second describe block doesn't hit the database a second time
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid}
  end

  describe "return value of authenticate method" do
    # The before block saves the user to the database so that it can be retrieved using find_by, which we accomplish using the let method
    before { @user.save }
    # let creates a local variable :found_user which is defined User.find_by(email: @user.email)
    let(:found_user) { User.find_by(email: @user.email) }

    # eq = equal
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      # specify and it are the same thing (difference between the two is readability)
      # Sounds strange "it user for invalid password should be false"; saying "specify: expect user for invalid password to be false" sounds better
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end