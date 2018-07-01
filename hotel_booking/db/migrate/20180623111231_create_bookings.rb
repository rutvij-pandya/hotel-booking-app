class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :hotel, index: true
      t.belongs_to :room_type, index: true
      t.integer :amount
      t.datetime :check_in_date
      t.datetime :check_out_date
      t.integer :status, limit: 1, default: Booking.statuses[:pending]
      t.timestamps
    end
  end
end
