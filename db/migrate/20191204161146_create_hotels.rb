class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name,                     null: false
      t.string :address
      t.attachment :picture
      t.integer :single_bedroom_price,    null: false
      t.integer :double_bedroom_price,    null: false
      t.integer :suite_room_price,        null: false
      t.integer :dormitory_room_price,    null: false
      t.integer :single_bedroom_num,      null: false
      t.integer :double_bedroom_num,      null: false
      t.integer :suite_room_num,          null: false
      t.integer :dormitory_room_num,      null: false
      t.float   :latitude,                null: false
      t.float   :longitude,               null: false
      t.float   :price
      t.timestamps
    end
  end
end
