class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone1
      t.string :phone2
      t.string :skype_id
      t.text :address
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
