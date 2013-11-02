class Planets
  class << self
    def all
      result = nil

      data.transaction(true) do |planets|
        result = collection(planets)
      end
      result
    end

    def add(planet)
      data.transaction do |planets| 
        collection(planets).push({
          coordinates:  planet.coordinates
        })
      end 
    end

    def find_by_coordinates(coordinates)
      result = nil
      data.transaction(true) do |planets|
        result = collection(planets).select { |planet| planet[:coordinates] == coordinates }.first
      end

      result
    end

    def find_first_unatacked_planet(attacked_coordinates)
      result = nil
      data.transaction(true) do |planets|
        result = collection(planets).select { |planet| planet[:coordinates] != attacked_coordinates }.first
      end

      result
    end

    def store_scraped_planets(scraped_coordinates)
      clean_planets = scraped_coordinates.each_with_object([]) do |coordinates, res|
        res.push({
          coordinates: Planet.new(coordinates).coordinates
        })
      end

      data.transaction do |planets|
        collection(planets).concat(clean_planets)
      end
    end

    private

    def data
      PStore.new("data/planets.pstore")
    end

    def collection(planets)
      planets[:collection] ||= Array.new
    end
  end
end

class Planet
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = sanitize_coordinates(coordinates)
  end

  def save
    Planets.add(self)
  end

  private

  def sanitize_coordinates(sanitize_coordinates)
    sanitize_coordinates.gsub(/\[|\]/, '')
  end
end