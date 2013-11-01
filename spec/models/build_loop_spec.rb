require_relative 'model_spec_helper'
require_relative '../../lib/obot/models/build_loop'

describe BuildLoop do
  before do
    remove_data('data/*')
  end

  describe "planet life" do
    let!(:subject){ BuildLoop.new('5:12:28', 1) }

    its(:to_h){ should eq({coordinates:'5:12:28', type: 1})}

    it "can be save" do
      subject.save
      BuildLoops.any?.should be_true
      BuildLoops.all.should include({coordinates:'5:12:28', type: '1'})
      Dir.entries('data').select do |entry| 
        entry.start_with?('build_')
      end.empty?.should be_true
      BuildLoops.any?.should be_false
    end
  end
end