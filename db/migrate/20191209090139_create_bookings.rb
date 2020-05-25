class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :num_of_guests,               null: false
      t.string :guest_name,                   null: false
      t.date :check_in_date,                  null: false
      t.date :check_out_date,                 null: false
      t.integer :single_bedroom_num,          default: 0
      t.integer :double_bedroom_num,          default: 0
      t.integer :suite_room_num,              default: 0
      t.integer :dormitory_room_num,          default: 0
      t.integer :total,                       default: 0
      t.references :hotel, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
