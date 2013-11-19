require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/planet'

describe Planet do
  before(:each) do
    remove_data
  end

  describe "planet life" do
    let!(:subject){ Planet.new('[5:12:28]') }

    its(:coordinates){ should eq('5:12:28')}

    it "can be save" do
      expect{ subject.save }.to_not raise_error
      Planet.all.should include(coordinates: '5:12:28')
    end
  end

  describe "bot usage of planet" do
    it "can be fill with an array of scrapped planets coordinates" do
      list = [
        '[2:189:12]', '[2:218:2]', '[4:187:5]'
      ]
      Planet.store_scraped_planets(list)

      Planet.all.should include({coordinates: '2:189:12'}, {coordinates: '2:218:2'}, {coordinates: '4:187:5'})
    end
  end
end