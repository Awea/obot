require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/large_carrier_fleet'

describe LargeCarrierFleet do
  before do
    remove_data('data/large_carrier_fleets.pstore')
  end

  describe "spaceship life" do
    let!(:subject){ LargeCarrierFleet.new(1, 12) }

    its(:planet_id){ should eq(1)}
    its(:population){ should eq(12)}

    it "can be save" do
      expect{ subject.save }.to_not raise_error
      LargeCarrierFleets.all.should include(planet_id: 1, population: 12)
    end
  end

  describe "spaceships collection" do
    it "get carriers count planet for a given planet" do
      LargeCarrierFleet.new(1, 12).save
      LargeCarrierFleet.new(3, 0).save

      expect(LargeCarrierFleets.available_by_planet(1)).to eq(12)
      expect(LargeCarrierFleets.available_by_planet(3)).to eq(0)
    end

    it "can transfert carriers from a planet to another" do
      LargeCarrierFleet.new(1, 12).save
      LargeCarrierFleet.new(2, 15).save

      expect{ LargeCarrierFleets.transfert(1, 2) }.to_not raise_error
      LargeCarrierFleets.all.should include(planet_id: 2, population: 27)
    end
  end
end