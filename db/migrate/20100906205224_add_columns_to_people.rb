class AddColumnsToPeople < ActiveRecord::Migration
  def self.up
  	  add_column :people, :nationality, :string
  	  add_column :people, :initials, :string
  	  add_column :people, :other, :text
  end

  def self.down
  	  remove_column :people, :nationality
  	  remove_column :people, :initials
  	  remove_column :people, :other
  end
end
