# Extends Numeric class
#
class Numeric

  include ActionView::Helpers::NumberHelper

  # Returns formatted currecy value
  def to_currency(unit = '$', precision = 2)
    number_to_currency(self, unit: unit, precision: precision)
  end
  
end