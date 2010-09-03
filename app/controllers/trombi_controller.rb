class TrombiController < ApplicationController
	
	def index
		@people = Person.find(:all)	
	end
	
	def list
		@people = Person.find(:all)
	end
	
	def show_details
		@person = Person.find(params[:id])
	end
	
	def search
		@query = params[:search]
		@people = Person.search(params[:search])
	end
	
	def account
		if request.post?
			if params[:password] != params[:password_confirmation]
				flash.now[:notice] = "Password and confirmation do not match."
			else
				user = User.authenticate_id(session[:user_id], params[:old_password])
				if user
					user.password = params[:password]
					user.save
					redirect_to(:controller => "trombi", :action=>"index")
					flash[:notice] = "Password changed."
				else
					flash.now[:notice] = "Old password is incorrect."
				end

			end
		end
	end
	
	def login
		session[:user_id]=nil
		session[:user_level]=nil
	
		  if request.post?
			  user = User.authenticate(params[:name], params[:password])
			  if user
				  session[:user_id]=user.id
				  session[:user_level]=user.level
				  redirect_to(:controller => "trombi", :action=>"index")
			  else
				  flash.now[:notice] = "Invalid user/password combination"
			  end
		  end
	end

	
	def logout
		session[:user_id]=nil
		session[:user_level]=nil
		redirect_to(:action => "index")
  	end
end
