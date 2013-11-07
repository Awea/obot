class LargeCarrierFleets
  class << self
    # Get all large carrier fleets
    # Return an array with each fleet in a hash
    def all
      result = nil

      data.transaction(true) do |lc_fleets|
        result = collection(lc_fleets)
      end
      result
    end

    def add(large_carrier_fleet)
      data.transaction do |large_carrier_fleets| 
        collection(large_carrier_fleets).push({
          planet_id:  large_carrier_fleet.planet_id,
          population: large_carrier_fleet.population
        })
      end 
    end

    def find(planet_id)
      result = nil
      data.transaction(true) do |spaceships|
        result = collection(spaceships).select { |spaceship| spaceship[:planet_id] == planet_id }.first
      end

      result
    end

    # Transfert all large carriers
    # From a planet to another
    def transfert(origin_id, destination_id)
      data.transaction do |spaceships|
        fleet_from = transaction_find(spaceships, origin_id)
        fleet_to   = transaction_find(spaceships, destination_id)

        fleet_to[:population]   = fleet_from[:population] + fleet_to[:population]
        fleet_from[:population] = 0
      end
    end

    def available_by_planet(planet_id)
      find(planet_id)[:population]
    end

    private

    def transaction_find(spaceships, planet_id)
      collection(spaceships).select { |spaceship| spaceship[:planet_id] == planet_id }.first
    end

    def data
      PStore.new("data/database.pstore")
    end

    def collection(spaceships)
      spaceships[:spaceships] ||= Array.new
    end
  end
end

class LargeCarrierFleet
  attr_reader :planet_id, :population

  def initialize(planet_id, population)
    @planet_id  = planet_id
    @population = population
  end

  def save
    LargeCarrierFleets.add(self)
  end
end