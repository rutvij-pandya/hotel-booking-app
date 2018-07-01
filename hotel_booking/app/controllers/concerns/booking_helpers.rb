module BookingHelpers
  extend ActiveSupport::Concern

  # TODO - store guest email address
  def create_booking(params) 
    room_type = RoomType.find(params[:room_type_id])
    hotel = room_type.hotel
    # re-confirm room's availability 
    availability_data = 
      Queries::RoomBookingQuery.new( check_in_date:   Date.parse(params[:check_in_date]),
                                     check_out_date:  Date.parse(params[:check_out_date]),
                                     hotel_id:        hotel.id,
                                     room_type_id:    room_type.id).execute.index_by(&:id)


    if room_availability(hotel, availability_data[hotel.id])[room_type.id][:available]
      # get payable_amount as per duration      
      params.merge!(amount: booking_amount(room_type, params))  
      # Create booking in 'Pending' status
      hotel.bookings.new(booking_attributes(params))
    else 
      raise Error::RoomNotAvailable
    end    
  end

  # Returns Room availability details,
  # to handle a case where a particular room type is not available, but other types are available
  def room_availability(hotel, hotel_availability)
    result = {}
    total_rooms_by_type = hotel.room_types.pluck(:id, :quantity).to_h

    if hotel_availability.present? && hotel_availability["availability"].present?
      hotel_availability["availability"].each do |data|
        quantity = total_rooms_by_type.delete(data["room_type_id"])
        key = data["room_type_id"]

        result[key] = {available: quantity > data["booked_quantity"]}
      end 
    end

    total_rooms_by_type.each do |room_type_id, quantity|
      result[room_type_id] = {available: true}
    end

    result
  end


  private

  # get payable_amount as per duration
  def booking_amount(room_type, options)
    RoomTypes::RoomRate.new(room_type,  check_in_date: options[:check_in_date], 
                                        check_out_date: options[:check_out_date]).payable_amount
  end

  def booking_attributes(params)
    {
      check_in_date:   params[:check_in_date],
      check_out_date:  params[:check_out_date],
      room_type_id:    params[:room_type_id],
      amount:          params[:amount]
    }
  end

end