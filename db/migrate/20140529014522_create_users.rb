class CreateUsers < ActiveRecord::Migration
  # change method that determines the change to be made to the database	
  def change
  	# change uses a Rails method called create_table to create a table in the database for storing users
  	# The create_table method accepts a block with one block variable, in this case called t (for "table")
    create_table :users do |t|
      # Inside the block, the create_table method uses the t object to create name and email columns in the database, both type string
      t.string :name
      t.string :email

      # t.timestamps, is a special command that creates two magic columns called created_at and updated_at, which are timestamps that automatically record when a given user is created and updated
      t.timestamps
    end
  end
end
