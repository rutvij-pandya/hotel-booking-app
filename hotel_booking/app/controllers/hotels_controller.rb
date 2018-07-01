class HotelsController < ApplicationController

  include HotelHelpers

  # GET /hotels.json
  def index
    @hotels = paginate_by(hotels_list, params[:page])        
  end  

end
