# Extend ActiveSupport::TimeWithZone class to add more methods 
# It is helpful to define fixed set of Date-Time formats that we wish to use across the product

class ActiveSupport::TimeWithZone

  ## Please find below reusable sample Time Formats that 
  ## can be used across the product to keep it consistent  

  # Short format i.e, "07 Dec, 2017"
  # call - obj.short.format
  #
  def short
    @time_format = "%d %b, %Y"
    self
  end

  # Long format i.e, "07 Dec, 2017 at 07:13am"
  # call - obj.long.format
  #
  def long
    @time_format = "%d %b, %Y at %I:%M%P"
    self
  end

  def time_only
    @time_format = "%H:%M:%S"
    self
  end

  # Formatter 
  def format
    self.strftime(@time_format)
  end  

  ## Note -
  ## It can be further extended to capture date style preference (DMY/ MDY/ YMD)
  ## to serve international customers based on their country for better readability
  
  # def ymd_short
  #   @time_format = "%Y-%m-%d"
  #   self
  # end

  # def ymd_long
  #   @time_format = "%Y-%m-%d %H:%M"
  #   self
  # end

end