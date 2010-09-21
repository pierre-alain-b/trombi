# This controller is only used by super-administrators (users with level >= 2) to manage users
class UsersController < ApplicationController
  layout "trombi"
	
  # Displays a list of authorized users
  def index
    @users = User.find(:all, :order=>:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # Show some details on a specific user
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # Creates a new user
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # Edits an existing users
  def edit
    @user = User.find(params[:id])
  end

  # Creates a new user
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
      	      flash[:notice] = "User #{@user.name} was succesfully created."
      	      format.html { redirect_to(:action => "index") }
      	      format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
      	      format.html { render :action => "new" }
      	      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  # Updates an existing user
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
      	      flash[:notice] = "User #{@user.name} was succesfully updated."
      	      format.html { redirect_to(:action=>"index") }
      	      format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroys an existing user
  def destroy
    @user = User.find(params[:id])
    begin
    	    @user.destroy
    	    flash[:notice] = "User #{@user.name} deleted" 	    
    rescue Exception => e
    	    flash[:notice] = e.message
    end
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  # Specific authorization function that overrides the default for application
  # Makes sure that only super-administrators (users with level >=2) access this administration panel
    def authorize
    	    if user=User.find_by_id(session[:user_id])
    	    	    unless user.level>1
    	    	    	    flash[:notice] = I18n.t('flash.login-super')
    	    	    	    redirect_to :controller => "trombi", :action => "login"
    	    	    end
    	  else
    	    	  flash[:notice] = "Please log in"
  	  	  redirect_to :controller => "trombi", :action => "login"
  	  end
  end  
  
end
