# frozen_string_literal: true
module RoomTypes::RateHelper
  extend ActiveSupport::Concern
  
  # Returns 'per_month' rate of the room
  def monthly_rate(check_in_date, check_out_date)
    rate = RoomTypes::RoomRate.new(self, check_in_date: check_in_date, check_out_date: check_out_date).per_month_amount
    formatted_amount(rate)
  end

  # Returns actual payable rate of the room depending on the duration of the stay
  # i.e, - Check In - 5th July 2018 - Check Out - 14th Aug 2018
  #       per_night_rate * 40, duration of stay is 40 days
  def payable_price(check_in_date, check_out_date)
    rate = RoomTypes::RoomRate.new(self, check_in_date: check_in_date, check_out_date: check_out_date).payable_amount
    formatted_amount(rate)
  end

  # Curreny formatting
  def formatted_amount(amount)
    Money.new(amount).dollars.ceil.to_currency
  end

end