require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/build_loop'

describe BuildLoop do
  before do
    BuildLoops.all.each(&:delete)
  end

  it "can be save and retrieved" do
    BuildLoop.new('5:12:28', 'su:deut').save
    BuildLoops.any?.should be_true
    first_build = BuildLoops.all.first 

    first_build.should be_kind_of(BuildLoop)
    first_build.planet_coordinates.should eq('5:12:28')
    first_build.type.should eq('su:deut')
  end

  it "can be deleted" do
    BuildLoop.new('5:12:28', 'su:deut').save
    BuildLoops.all.first.should be_kind_of(BuildLoop)
    BuildLoops.all.first.delete
    BuildLoops.any?.should be_false
  end
end