require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/build_loop'

describe BuildLoop do
  before do
    remove_data
  end

  describe "what i'm doing" do
    let!(:subject){ BuildLoop.new('5:12:28', 'su:deut') }

    it "is deleted after it was used" do
      subject.save
      BuildLoops.any?.should be_true
      BuildLoops.all.first.should be_kind_of(BuildLoop)
      BuildLoops.any?.should be_false
    end
  end
end