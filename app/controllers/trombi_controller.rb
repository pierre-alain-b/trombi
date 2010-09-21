# Main controller of the Trombi application.
# This controller is accessible by any authentified user and gives access to the list of people registered within the Trombinoscope
class TrombiController < ApplicationController
	
	# Index page - displayed after login for all users
	def index
		# Retrieve the last three people added
		@last_three = Person.find(:all, :limit => 3, :order => "id DESC")
		# Retrieve an aleatory page - pretty cool to memorize names and pictures !
		@lottery_winner = Person.find(:first, :offset => ( Person.count * rand ).to_i )
	end
	
	# Displays a list of all people
	def list
		@people = Person.find(:all, :order=>"LOWER(last_name) ASC")
	end
	
	# Displays a detailed page with details for the chosen person
	def show_details
		@person = Person.find(params[:id])
	end
	
	# Executes a search query on the database (cf. model file for the definition of Person.search)
	def search
		@query = params[:search]
		@people = Person.search(params[:search])
	end
	
	# Management of the account of the user
	# The user can change its password and its default language
	def account
		@user=User.find_by_id(session[:user_id])
		
		#Only goes further if there is a request to process
		if request.post?
			
			#If the request concerns the default language */
			if params[:commit] == I18n.t('views.trombi.account.change_language')
				@user.default_language = params[:default_language]
				@user.save
				session[:user_default_language] = params[:default_language]
				redirect_to(:controller => "trombi", :action=>"account")
				flash[:notice] = I18n.t 'flash.language_updated', :locale => params[:default_language]
					
			#If the request concerns the password */	
			elsif params[:commit] == I18n.t('views.trombi.account.change_password')
			
				if params[:password] != params[:password_confirmation]
					flash.now[:notice] = I18n.t('flash.confirmation_not_match')
				else
					user = User.authenticate_id(session[:user_id], params[:old_password])
					if user
						user.password = params[:password]
						user.save
						redirect_to(:controller => "trombi", :action=>"index")
						flash[:notice] = I18n.t('flash.password_updated')
					else
						flash.now[:notice] = I18n.t('controller.trombi.account.wrong_old_password')
					end
	
				end
			end
		end
	end
	
	# Manages the authentification process with the login page
	def login
		# If the person is redirected to the login page, then previous session informations are erased
		session[:user_id]=nil
		session[:user_level]=nil
		flash.now[:notice]=I18n.t('flash.login')
	
		  if request.post?
			  user = User.authenticate(params[:name], params[:password])
			  if user
				  session[:user_id]=user.id
				  session[:user_level]=user.level
				  session[:user_default_language]=user.default_language
				  redirect_to(:controller => "trombi", :action=>"index")
			  else
				  flash.now[:notice] = I18n.t('flash.wrong_password')
			  end
		  end
	end

	# Manages the logout process
	def logout
		session[:user_id]=nil
		session[:user_level]=nil
		redirect_to(:action => "index")
  	end
end
