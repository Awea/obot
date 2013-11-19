class Planet
  attr_reader :coordinates

  class << self
    def all
      result = nil

      pstore.transaction(true) do |pstore|
        result = collection(pstore)
      end
      result
    end

    def add(planet)
      pstore.transaction do |pstore| 
        collection(pstore).push({
          coordinates:  planet.coordinates
        })
      end 
    end

    def find_by_coordinates(coordinates)
      result = nil
      pstore.transaction(true) do |pstore|
        result = collection(pstore).select { |planet| planet[:coordinates] == coordinates }.first
      end

      result
    end

    def find_first_unatacked_planet(attacked_coordinates)
      result = nil
      pstore.transaction(true) do |pstore|
        result = collection(pstore).select { |planet| planet[:coordinates] != attacked_coordinates }.first
      end

      result
    end

    def store_scraped_planets(scraped_coordinates)
      clean_planets = scraped_coordinates.each_with_object([]) do |coordinates, res|
        res.push({
          coordinates: self.new(coordinates).coordinates
        })
      end

      pstore.transaction do |pstore|
        collection(pstore).concat(clean_planets)
      end
    end

    private

    def pstore
      PStore.new("data/database.pstore")
    end

    def collection(pstore)
      pstore['planets'] ||= Array.new
    end
  end

  def initialize(coordinates)
    @coordinates = sanitize_coordinates(coordinates)
  end

  def save
    Planet.add(self)
  end

  private

  def sanitize_coordinates(sanitize_coordinates)
    sanitize_coordinates.gsub(/\[|\]/, '')
  end
end