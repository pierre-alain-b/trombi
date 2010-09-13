# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


#Create a first user to set up the system - this user should preferably be deleted
User.create(:name => "admin", :password => "password", :password_confirmation => "password", :level => "2", :default_language => "en")
