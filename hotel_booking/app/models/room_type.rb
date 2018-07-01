class RoomType < ApplicationRecord

  include RoomTypes::RateHelper

  # --- Associations
  belongs_to :hotel
  has_many :pictures, as: :imageable
  has_many :room_type_rate_schedules
  has_many :bookings

  # -- Callbacks


  # -- Enums


  # -- Scopes  

  # amount field is a money object instead of plain number
  monetize :base_rate, as: :rate


end
