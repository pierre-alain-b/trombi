class Person < ActiveRecord::Base
	acts_as_fleximage :image_directory => 'public/images/uploaded_photos'
	
	validates_presence_of :first_name, :last_name, :email
	
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	
	#validates_format_of :image_url, :with => %r{\.(gif|jpg|png)$}i, :message => 'must be a URL for a GIF, JPG or PNG image.'
	
	def self.search(search)
           if search
           	   find(:all, :conditions => ["first_name LIKE ? or last_name LIKE ? or email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%"], :order => 'last_name DESC')
           else
           	   find(:all, :order => 'last_name DESC')
           end
       end
end