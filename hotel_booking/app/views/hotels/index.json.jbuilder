json.array! @hotels do |hotel| 
  json.partial! '/hotels/hotel', hotel: hotel
end