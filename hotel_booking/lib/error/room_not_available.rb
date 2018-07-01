## Case for which this exception should be raised -
# When user was exploring different hotel options, the selected RoomType of a hotel was available
# User might have left the page open for some time, 
#   so system re-confirms the availability of the selected hote-room type
#   and raises an exception, if not available at the time of booking

module Error
  class RoomNotAvailable < CustomError
    def initialize
      super(:room_not_available, 422, I18n.t('custom_errors.room_not_available'))
    end
  end
end
