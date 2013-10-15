class Planets
  class << self
    def table_name
      :planets
    end

    def find_by_coordinates(coordinates)
      puts "find_by_coordinates #{coordinates}"
      items.where("coordinates == '#{coordinates}'").first
    end

    def create_table
      DB.create_table table_name do
        primary_key :id
        String :coordinates
      end
    end

    def store_planets(planets)
      planets.each do |planet|
        items.insert(coordinates: planet)
      end

      items
    end

    def items
      DB[table_name] 
    end
  end
end