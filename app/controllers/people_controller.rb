# The People controller is used for the administration of the pages of the Trombi
# This controller is only accessible to user with level > 0
class PeopleController < ApplicationController
	layout "trombi"
	caches_page :show
	
  # Display the index with the list of the pages of the Trombi
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # Display a specified page with details
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.jpg   # show.jpg.flexi
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # Add a new page (person) to the Trombi
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # Edit an existing page for a person
  def edit
    @person = Person.find(params[:id])
  end

  # Create a new page
  def create
    @person = Person.new(params[:person])
    # If no image is chosen, a default file is used.
      	 if params[:image_file].nil? and params[:image_file_url].nil?
  	  	  @person.image_file_url="#{HOST_ROOT}/images/default-picture.gif"
  	  	  puts @person.image_file_url
  	 end

    respond_to do |format|
      if @person.save
      	format.html { redirect_to(@person, :notice => I18n.t('controller.people.successfully_created')) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update an existing page
  def update
    @person = Person.find(params[:id])
    expire_person(@person)
    
    respond_to do |format|
      if @person.update_attributes(params[:person])
      	format.html { redirect_to(@person, :notice => I18n.t('controller.people.successfully_updated') ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Delete an existing page
  def destroy
    @person = Person.find(params[:id])
    expire_person(@person)
    @person.destroy
    
    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
  
  
private
	# Manage the expiration of cached pages and pictures for deleted/updated pages of the  Trombi
	def expire_person(person)
		expire_page :controller => "people", :action => "show"
		expire_page person_path(person, :jpg)
	end

protected
	# Authorization function specitif to the People (aka administration) controller.
	# It overrides the general authorization function.
	# Makes sure that only administrator users (level > 0) access the panel.
	def authorize
		 if user=User.find_by_id(session[:user_id])
			    unless user.level>0
				    flash[:notice] = I18n.t('flash.login-super')
				    redirect_to :controller => "trombi", :action => "login"
			    end
		 else
			  flash[:notice] = "Please log in"
			  redirect_to :controller => "trombi", :action => "login"
		 end
	end
  
end
