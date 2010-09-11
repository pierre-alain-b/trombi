class AddUsersDefaultLanguage < ActiveRecord::Migration
  def self.up
  	  add_column :users, :default_language, :string
  end

  def self.down
  	  remove_column :users, :default_language
  end
end
