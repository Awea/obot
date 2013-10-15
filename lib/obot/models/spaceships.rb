class Spaceships
  class << self
    def table_name
      :spaceships
    end

    def create_table
      DB.create_table table_name do
        primary_key :id
        foreign_key :planet_id, :planets
        String :type
      end
    end

    def add_transports_to_planet(transports_count, planet_id)
      transports_count.to_i.times do 
        puts "add transport to  #{planet_id}"
        items.insert(type: 'grand_transport', planet_id: planet_id)
      end

      items
    end

    def transfert_transports(coordinates_origin, destination_id)
      origin_id = Planets.find_by_coordinates(origin)[:id]

      items.where("planet_id == '#{origin_id}'").update(planet_id: destination_id)
    end

    def items
      DB[table_name] 
    end
  end
end