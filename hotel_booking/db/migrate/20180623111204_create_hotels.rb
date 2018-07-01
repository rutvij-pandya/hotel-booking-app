class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.string :slug, null: false, index: true
      t.integer :minimum_stay, limit: 1, default: 30
      # Note - Please refer comments about 'enum status' in app/models/hotel.rb
      t.integer :status, limit: 1, default: Hotel.statuses[:pending]
      t.timestamps
    end
  end
end
