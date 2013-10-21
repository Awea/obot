class Planets
  class << self
    def all
      items.all
    end

    def table_name
      :planets
    end

    def find_by_coordinates(coordinates)
      puts "find_by_coordinates #{coordinates}"
      items.where("coordinates == '#{coordinates}'").first
    end

    def find_first_unatacked_planet(attacked_coordinates)
      items.where("coordinates != '#{attacked_coordinates}'").first
    end

    def create_table
      DB.create_table table_name do
        primary_key :id
        String :coordinates
      end
    end

    def store_planets(planets)
      planets.each do |planet|
        puts "insert planet #{planet}"
        items.insert(coordinates: planet)
      end

      items
    end

    def items
      DB[table_name] 
    end
  end
end