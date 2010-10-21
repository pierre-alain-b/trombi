#Base controller for the application - it contains the default filters concerning languages and authentification
class ApplicationController < ActionController::Base
  
	#Filters for authentification for all pages except login/logout
	before_filter :authorize, :except => [:login,:logout]
	#Filters for use of locales
	before_filter :set_locale
	
	helper :all # include all helpers, all the time
	protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected
  
  #Check if the user is signed in and if not redirect it to the login page
  def authorize
  	  unless User.find_by_id(session[:user_id])
  	  	  redirect_to :controller => "trombi", :action => "login"
  	  end
  end
  
  #Definition of locales for the application
  def set_locale
  	  I18n.locale = session[:user_default_language] || I18n.default_locale

  	  locale_path="#{LOCALES_DIRECTORY}#{I18n.locale}.yml"
  	  
  	  unless I18n.load_path.include? locale_path
  	  	  I18n.load_path << locale_path
  	  	  I18n.backend.send(:init_translations)
  	  end
  	 
  	  rescue Exception => err
		  logger.error err
		  flash.now[:error]= "#{I18n.locale} translation is not available. La traduction #{I18n.locale} n'est pas disponible."
		  I18n.load_path -= [locale_path]
		  I18n.locale = session[:user_default_language] = I18n.default_locale
  end
  
  
end
