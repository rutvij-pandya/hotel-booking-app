json.id encode(room_type.id)
json.name room_type.name
json.occupancy_limit room_type.occupancy_limit
json.available availability
json.rate room_type.monthly_rate(duration[:check_in_date], duration[:check_out_date])