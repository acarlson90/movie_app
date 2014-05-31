# User class inherits from ActiveRecord::Base, so that the User model automatically has all the functionality of the ActiveRecord::Base class
class User < ActiveRecord::Base
	# Make sure that the email address is all lower-case before it gets saved to the database. The reason is that not all databases adapters use case-sensitive indices.
	# The way to do this is with a callback, which is a method that gets invoked at a particular point in the lifetime of an Active Record object.
	# Use a before_save callback to force Rails to downcase teh email attribute before saving the user to the database
	# The code passes a block to the before_save callback and sets the user's email address to a lower-case version of its current value using downcase string method. 
	before_save { self.email = email.downcase } # this is the same = before_save { email.downcase! }

	# Validates is a method that verifies a name and email is given
	validates :name,  presence: true, length: { maximum: 50 }
	# The application code for email format validation uses a regular expression (or regex) to define the format, along with the :format argument to the validates method
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  	# Here the regex VALID_EMAIL_REGEX is a constant, indicated in Ruby by a name starting with a capital letter. This ensures that only email addresses that match the pattern will be considered valid
  	validates :email, presence: 	true, 
  					  format: 		{ with: VALID_EMAIL_REGEX}, 
  					  uniqueness: 	{ case_sensitive: false }

  	# Gets the password RSpec tests to pass
  	has_secure_password
  	
  	validates :password, length: { minimum: 6 }
end
