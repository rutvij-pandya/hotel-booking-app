module Hotels
  module ActionsHelper
    include BookingHelpers

    # Returns Hotel's availability
    def hotel_availability(hotel, hotel_availability)
      result = true

      if hotel_availability.present?
        # Total available rooms in a hotel
        total_rooms = hotel.room_types.sum(&:quantity)    
        result = (total_rooms != hotel_availability["booked_rooms"])
      end
      
      result
    end

    # Availability display format
    def hotel_availability_format(availability)
      availability ? I18n.t('hotel.availability.available') : I18n.t('hotel.availability.full')
    end

  end
end
