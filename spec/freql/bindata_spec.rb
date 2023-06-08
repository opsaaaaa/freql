# frozen_string_literal: true
RSpec.describe Freql::BinData do

  context "class" do
    subject { Freql::BinData }

    it "can .pack a hash into bin data" do
      expect(subject.pack(
        {'two'=> 2, :three => 3, '3'=>3, 'five' => 5, '5'=>5}
      )).to eq(
        [[],[],['two'],[:three, '3'],[],['five', '5']]
      )
    end

    it "can .unpack bin data into a hash" do
      expect(subject.unpack(
        [[],[],['two'],[:three, '3'],[],['five', '5']]
      )).to eq(
        {'two'=> 2, :three => 3, '3'=>3, 'five' => 5, '5'=>5}
      )
    end
  end

  context "instance" do
    subject {
      Freql::BinData.new([[],['1', 'one'],[],['3', 'three'],['4', 'four']])
    }

    it "can .filter_groups" do
      expect(
        subject.filter_groups {|item| item.match?(/[^a-z]/) }
      ).to eq([[],['1'],[],['3'],['4']])
    end

    it "can .unpack instance" do
      expect(subject.unpack).to eq(
        {'1'=>1,'one'=>1,'4'=>4,'four'=>4,'3'=>3,'three'=>3}
      )
    end

    it "can be converted from bin values bin .rank" do
      # the .rank will group ties. use .flatten for a flat array with no ties.
      rank = subject.rank
      expect(rank).to eq(
        [['1', 'one'],['3', 'three'],['4','four']]
      )
      expect(rank[0]).to eq(['1','one'])
    end

    it "can be .flatten-ed" do
      expect(subject.flatten).to eq(['1','one','3','three','4','four'])
    end
  end

end

