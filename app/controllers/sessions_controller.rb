class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in"
			redirect_to root_path
		else
			flash[:danger] = "Incorrect username and password combination"
			redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have successfully logged out"
		redirect_to root_path
	end
end