# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class DataSeed

  class << self

    def populate_seeds_data
      Rails.logger = Logger.new(STDOUT)

      remove_hotels_data

      populate_hotels_data
    end


    private

    def remove_hotels_data
      Rails.logger.info "--- Removing Hotels data"

      entities = ["Hotel", "RoomType", "RoomTypeRateSchedule"]

      entities.each do |entity|         
        model_klass = entity.constantize
        table_name = model_klass.table_name

        # Truncate entities tables
        truncate(model_klass, table_name)
      end
    end

    def populate_hotels_data
      Rails.logger.info "--- Populating Hotels data"
      load_seeds_data("hotels").values.each do |data|
        hotel = Hotel.new(name: data["name"], minimum_stay: data["minimum_stay"])
        hotel.build_picture(image_url: data["cover_picture"])
        hotel.save!

        data["room_types"].each do |rt_data|
          room_type = hotel.room_types.create(name: rt_data["name"],
                                              occupancy_limit: rt_data["occupancy_limit"],
                                              quantity: rt_data["quantity"],
                                              base_rate: rt_data["base_rate"])

          if rt_data["rates_schedule"].present?
            room_type.room_type_rate_schedules.create(rt_data["rates_schedule"])
          end
        end
        
        
        


        # Update status of Hotels that are ready to accept bookings
        hotel.active!
      end
    end


    # Load seeds data of a given entity/ model
    def load_seeds_data(table_name)
      seed_file = Rails.root.join('db','seeds_data',"#{table_name}.yml")
      YAML::load_file(seed_file)
    end

    # Truncate table of a given entity/ model
    def truncate(model_klass, table_name)
      model_klass.connection.truncate(model_klass.table_name)
    end
  end

end


DataSeed.populate_seeds_data

