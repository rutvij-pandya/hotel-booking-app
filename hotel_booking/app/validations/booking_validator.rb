class BookingValidator < ActiveModel::Validator

  def validate(record)

    return false if record.check_in_date.blank? || record.check_out_date.blank?
    # check_in_date, check_out_date cannot be in past
    if dates_in_past(record)
      record.errors.add(:base, I18n.t('custom_errors.dates_in_past'))
    end
    # check_out_date cannot be less than check_in_date
    if invalid_date_range(record)
      record.errors.add(:base, I18n.t('custom_errors.invalid_date_range'))
    end
    # min duration between check_in_date, check_out_date 
    if invalid_duration(record)
      record.errors.add(:base, I18n.t('custom_errors.invalid_duration'))
    end  
    
  end

  private

  def dates_in_past(record)
    date_today = Date.today
    (record.check_in_date.to_date < date_today) || (record.check_out_date.to_date < date_today)
  end

  def invalid_date_range(record)
    (record.check_out_date.to_date < record.check_in_date.to_date)
  end

  def invalid_duration(record)
    ((record.check_in_date.to_date..record.check_out_date.to_date).count < record.hotel.minimum_stay)
  end

end