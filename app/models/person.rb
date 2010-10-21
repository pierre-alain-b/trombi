# Person records should require:
# * first_name
# * last_name
# * email
# all other attributes are optional
# If no image is specified, the controller chooses a default image (cf. people controller, create function)
class Person < ActiveRecord::Base
  
	#acts_as_fleximage do
	#	image_directory 'public/images/uploaded_photos'
	#end
	
  has_attached_file :avatar, 
                    :default_url => "/images/:attachment/missing_:style.png",
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }
                                
  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']

	validates_presence_of :first_name, :last_name, :email
	
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	
	#validates_format_of :image_url, :with => %r{\.(gif|jpg|png)$}i, :message => 'must be a URL for a GIF, JPG or PNG image.'
	
	# Search function used for the internal search motor
	# The query is searched in the fields:
	# * first_name
	# * last_name
	# * email
	# * other
	# * initials
	def self.search(search)
           if search
           	   find(:all, :conditions => ["first_name LIKE ? or last_name LIKE ? or email LIKE ? or other LIKE ? or initials LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"], :order => 'LOWER(last_name) ASC')
           else
           	   find(:all, :order => 'LOWER(last_name) ASC')
           end
       end
end
