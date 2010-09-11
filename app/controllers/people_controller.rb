class PeopleController < ApplicationController
	layout "trombi"
	caches_page :show
	
  # GET /people
  # GET /people.xml
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.jpg   # show.jpg.flexi
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

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

  # PUT /people/1
  # PUT /people/1.xml
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

  # DELETE /people/1
  # DELETE /people/1.xml
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
def expire_person(person)
	expire_page :controller => "people", :action => "show"
	expire_page person_path(person, :jpg)
end

protected
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