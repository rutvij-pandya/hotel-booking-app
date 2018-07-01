# Calculate room rate
require 'dry-initializer'

class RoomTypes::RoomRate
  extend Dry::Initializer

  # ActiveRecord 'room_types' object
  param :room_type
  # Booking period starts from
  option :check_in_date
  # Booking period ends at
  option :check_out_date


  # Returns 'per_month' rate of the room
  def per_month_amount
    room_rate
  end
  
  # Returns actual payable rate of the room depending on the duration of the stay
  # i.e, - Check In - 5th July 2018 - Check Out - 14th Aug 2018
  #       per_night_rate * 40, duration of stay is 40 days 
  def payable_amount
    room_rate(duration)
  end

  private

  def room_rate(duration = 30)
    floating_rates.push(base_rate).average(0) * duration
  end

  def base_rate
    room_type.base_rate
  end

  def floating_rates
    room_type.room_type_rate_schedules.overlapping(check_in_date, check_out_date).pluck(:rate).uniq
  end

  def duration
    (check_in_date..check_out_date).count
  end
  
end