class AddAttachmentPictureToHotels < ActiveRecord::Migration[5.2]
  def self.up
    change_table :hotels do |t|
      t.attachment :picture
      t.float :latitude
      t.float :longitude
      t.string :address

    end
  end

  def self.down
    remove_column :hotels, :address
    remove_column :hotels, :longitude
    remove_column :hotels, :latitude
    remove_attachment :hotels, :picture

  end
end
