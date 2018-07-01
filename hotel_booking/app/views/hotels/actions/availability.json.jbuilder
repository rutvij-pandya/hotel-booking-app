json.hotel do 
  json.partial! '/hotels/hotel', hotel: @hotel
end

available_room_types = room_availability(@hotel, @hotels_availability[@hotel.id])

json.room_types @hotel.room_types do |room_type|
  json.partial! '/room_types/room_type',  room_type: room_type, 
                                          availability: available_room_types[room_type.id][:available], 
                                          duration: {check_in_date: params[:check_in_date], check_out_date: params[:check_out_date]}
end

json.availability do 
  json.check_in_date params[:check_in_date]
  json.check_out_date params[:check_out_date]
  json.available hotel_availability(@hotel, @hotels_availability[@hotel.id])
end