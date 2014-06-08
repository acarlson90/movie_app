class UsersController < ApplicationController
  # defines the @user variable used in the views/users/show file 
  # Uses the find method on the User model to retreive the user from the database
  def show
  	# Used params to retrieve the user id
  	@user = User.find(params[:id])
  end

  # defines the @user variable for the views/users/new file
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Aaron's Movie Database App!"
      redirect_to @user
    else
      # Render (assigns new to render (ex: views/layouts/applications.html.erb - render 'layouts/shim')), works on controller structure, which allows us to handle the
      # case of failure and success separately based on the value of @user.save
      render 'new'
    end
  end

  # private methods are not visible to users
  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
