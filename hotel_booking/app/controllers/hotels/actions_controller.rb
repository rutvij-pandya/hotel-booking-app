module Hotels
  # - The actions that users perform on 'hotels' which do not clearly belong to any of the restful
  # methods on Hotels controller are written on this class. 
  # - Such extra actions should ideally grouped and separated into other controllers 
  # to avoid one giant mess.
  class ActionsController < ApplicationController

  include HotelHelpers

  # GET  /hotels/:id/availability?room_type_id= &check_in_date= &check_out_date=
  def availability
    @hotels_availability = 
      Queries::RoomBookingQuery.new(booking_query_params).execute.index_by(&:id)
  end


  private

  def permitted_params
    params.permit!.merge!(params_to_merge)
  end

  # Set default values 
  def params_to_merge
    {}.tap do |param|
      # Decode room_type_id, if it is present
      param[:room_type_id] = decode(params[:room_type_id]) if params[:room_type_id].present?
      # Set Default check in date, if it's not present
      params[:check_in_date] = default_check_in_date unless params[:check_in_date].present?
      # Set Default check out date, if it's not present
      params[:check_out_date] = default_check_out_date unless params[:check_out_date].present?
    end
  end

  # Build params hash for 'Queries::RoomBookingQuery'
  def booking_query_params
    query_params = permitted_params.merge(hotel_id: current_hotel.id)
    {
      check_in_date: query_params[:check_in_date],
      check_out_date: query_params[:check_out_date],
      hotel_id: query_params[:hotel_id],
      room_type_id: query_params[:room_type_id]
    }
  end

  end
end