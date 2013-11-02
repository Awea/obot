require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/planet'

describe Planet do
  before do
    remove_data('data/planets.pstore')
  end

  describe "planet life" do
    let!(:subject){ Planet.new('[5:12:28]') }

    its(:coordinates){ should eq('5:12:28')}

    it "can be save" do
      expect{ subject.save }.to_not raise_error
      Planets.all.should include(coordinates: '5:12:28')
    end
  end

  describe "spaceships collection" do
    it "can be fill with an array of scrapped planets coordinates" do
      list = [
        '[2:189:12]', '[2:218:2]', '[4:187:5]'
      ]
      Planets.store_scraped_planets(list)

      Planets.all.should include({coordinates: '2:189:12'}, {coordinates: '2:218:2'}, {coordinates: '4:187:5'})
    end
  end
end