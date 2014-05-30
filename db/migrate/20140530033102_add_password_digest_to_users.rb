class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	# This code uses the add_column method to add a password_digest column to the users table
    add_column :users, :password_digest, :string
  end
end
