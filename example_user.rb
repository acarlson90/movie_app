class User
	# creates attributes accessors corresponding to a user's name and email address
	# This creates "getter" and "setter" methods that allows use to retrieve (get) and assign (set) @name and @email instance variables
	  # In Rails, the principal importance of instance variables is that they are automatically available in the views, but in general they are used for variables that need to be avaiable throughtout a Ruby class
	  # Instance variables always begin with an @ sign, and are nil when undefined
	attr_accessor :name, :email

	# initialize, is special in Ruby: it's the method called when we execute User.new
	# This particular initialize tkes one argument, attributes:
	# Here the attributes variables has a default value equal to the empty hash, so that we can define a user with no name or email address
	def initialize(attributes = {})
		@name = attributes[:name]
		@email = attributes[:email]
	end

	# Finally, our class defines a method called formatted_email that uses the values of the assigned @name and @email variables to build a nicely formatted verson of the user's email address using string interpolation
	# Because @name and @email are both instance variables (as indicated with the @ sign), they are automatically available in the formatted_email method
	def formatted_email
		"#{@name} <#{@email}>"
	end
end