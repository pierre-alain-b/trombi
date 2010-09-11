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
	
	def login
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

	
	def logout
		session[:user_id]=nil
		session[:user_level]=nil
		redirect_to(:action => "index")
  	end
end
