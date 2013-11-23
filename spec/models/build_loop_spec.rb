require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/build_loop'

describe BuildLoop do
  before do
    remove_data
  end

  describe "save and retrieve a build order" do
    before do 
      BuildLoop.new('5:12:28', 'su:deut').save
    end

    let(:subject){ BuildLoops.all.first }

    its(:planet_coordinates){ should eq('5:12:28') }
    its(:type){ should eq('su:deut') }

    it "exist" do
      BuildLoops.any?.should be_true
      subject.should be_kind_of(BuildLoop)
    end
  end

  it "is deleted " do
    BuildLoop.new('5:12:28', 'su:deut').save
    BuildLoops.all.first.should be_kind_of(BuildLoop)
    BuildLoops.any?.should be_false
  end
end