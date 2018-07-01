class Booking < ApplicationRecord 

  include AASM
  
  # --- Associations
  belongs_to :hotel
  belongs_to :room_type
  has_one :payment

  # --- Validations
  validates_presence_of :check_in_date, :check_out_date
  # Custom Validations      
  validates_with BookingValidator

  # -- Enums
  enum status: [:pending, :confirmed, :failed, :canceled]
  # State machine implementation
  include Bookings::StateHelper

  # --- Scopes


  # amount field is a money object instead of plain number
  monetize :amount, as: :booking_amount



end
