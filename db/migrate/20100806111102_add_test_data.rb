class AddTestData < ActiveRecord::Migration
  def self.up
  	  Person.delete_all
  	  Person.create(
  	  	  :first_name => 'François',
  	  	  :last_name =>	'Migeot',
  	  	  :email => 'migeotfr@free.fr',
  	  	  :image_url => '/images/default-picture.gif')
  	  Person.create(
  	  	  :first_name => 'Olivier',
  	  	  :last_name =>	'Migeot',
  	  	  :email => 'olivier@migeot.org',
  	  	  :image_url => '/images/default-picture.gif')
  	  Person.create(
  	  	  :first_name => 'Pierre-Alain',
  	  	  :last_name =>	'Bandinelli',
  	  	  :email => 'pab@melix.net',
  	  	  :image_url => '/images/default-picture.gif')  
  end

  def self.down
  end
end
