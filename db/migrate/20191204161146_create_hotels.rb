class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name,                     null: false
      t.string :address
      t.attachment :picture
      t.float   :single_bedroom_price,    null: false, default: 0.0
      t.float   :double_bedroom_price,    null: false, default: 0.0
      t.float   :suite_room_price,        null: false, default: 0.0
      t.float   :dormitory_room_price,    null: false, default: 0.0
      t.integer :single_bedroom_num,      null: false, default: 0
      t.integer :double_bedroom_num,      null: false, default: 0
      t.integer :suite_room_num,          null: false, default: 0
      t.integer :dormitory_room_num,      null: false, default: 0
      t.float   :latitude,                null: false, default: 0.0
      t.float   :longitude,               null: false, default: 0.0
      t.float   :price,                   null: false, default: 0.0
      t.timestamps
    end
  end
end
