class RoomTypeRateSchedule < ApplicationRecord

  # --- Associations
  belongs_to :room_type

  # --- Scopes
  # Returns all interval overlapping the given interval, excluding the given interval itself
  scope :overlapping, ->  (start_date, end_date) { where("start_date <= ? AND ? <= end_date", end_date, start_date) }

  # amount field is a money object instead of plain number
  monetize :rate, as: :floating_rate

end
