class CreateRoomTypeRateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :room_type_rate_schedules do |t|
      t.belongs_to :room_type
      t.datetime :start_date
      t.datetime :end_date
      t.integer :rate
      t.timestamps

      t.index [:room_type_id, :start_date, :end_date], name: "UNIQUE", unique: true
    end
  end
end
