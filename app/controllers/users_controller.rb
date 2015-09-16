class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to PostIt! Your account has been created and you have been logged in"
			redirect_to root_path
		else
			render :new
		end
	end

	def show
		@action = "View"
		@option = "Edit My Profile"
		@user = current_user
	end

	def edit
		@action = "Edit"
		@option = "Update"
		@user = current_user
	end

		def update
		@user = current_user
		if @user.update(user_params)
			flash[:success] = "Your profile has been updated"
			redirect_to user_path(@user)
		else
			flash[:danger] = "Your changes were not saved"
			redirect_to :back
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :password)
	end
end