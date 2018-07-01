module HotelHelpers
  extend ActiveSupport::Concern

  PER_PAGE = 20

  # Returns current hotel from the `params[:id]`
  def current_hotel
    @hotel ||= Hotel.by_slug(params[:id]).first
  end

  def hotels_list
    @list ||= Hotel.active.includes(:picture, :room_types).references(:picture, :room_types)
  end

  def default_check_in_date
    Date.today
  end

  def default_check_out_date
    default_check_in_date + 1.month
  end

  # Paginates the hotels based on the count and page
  def paginate_by(relation, page = 1, count = PER_PAGE)
    relation.page(page).per(count)
  end

end