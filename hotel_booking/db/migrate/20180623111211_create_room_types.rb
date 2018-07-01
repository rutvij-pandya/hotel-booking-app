class CreateRoomTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :room_types do |t|
      t.string :name, null: false
      t.belongs_to :hotel, index: true
      t.integer :occupancy_limit, limit: 1
      t.integer :quantity, limit: 2
      t.integer :base_rate
      t.timestamps
    end
  end
end
