# Find list of bookings made against hotels for the search period
require 'dry-initializer'

class Queries::RoomBookingQuery
  extend Dry::Initializer

  # Booking period starts from
  option :check_in_date
  # Booking period ends at
  option :check_out_date

  # Params hotel_id (O), room_type_id (O) are expected to check availability 
  # of a particular hotel-room for the search period before booking
  option :hotel_id, optional: true
  option :room_type_id, optional: true


  def execute
    Booking.select("s.hotel_id as id, count(*) as booked_rooms, to_json(array_agg(s)) AS availability ")
           .from(room_reservations_subquery, :s)
           .group("s.hotel_id")
  end


  private

  def room_reservations_subquery
    relation =  Booking.select("hotel_id, room_type_id, count(*) as booked_quantity")
                       .where("check_in_date <= ? AND ? <= check_out_date", check_out_date, check_in_date)
                       .where(status: [Booking.statuses[:pending], Booking.statuses[:confirmed]])
                       .group(:hotel_id, :room_type_id)
    
    # Filter by hotels      
    relation.where(hotel_id: hotel_id) if hotel_id.present?
    # Filter by room types
    relation.where(room_type_id: room_type_id) if room_type_id.present?

    relation
  end

end