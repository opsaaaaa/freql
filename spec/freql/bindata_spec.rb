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

  context "txt conversion" do
    let(:path) {'tmp/spec/to_txt.txt'}
    let(:txt) {"\n1 one\n\n3 three\n4 four"}
    subject {
      Freql::BinData[[],['1', 'one'],[],['3', 'three'],['4', 'four']]
    }
    it(".to_txt") {expect(subject.to_txt).to eq(txt)}
    it(".write_txt") {
      subject.write_txt(path)
      expect(File.exist?(path)).to eq(true)
      expect(File.read(path)).to eq(txt)
    }
  end

  context "instance" do
    subject {
      Freql::BinData[[],['1', 'one'],[],['3', 'three'],['4', 'four']]
    }

    it "can .filter_bin" do
      expect(
        subject.filter_bin {|item| item.match?(/[^a-z]/) }
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

    it "can be written to a file and retrieved" do
      path = 'tmp/spec/bindata_spec.msgpack.gz'
      subject.write_msgpack_gz(path)
      expect(File.exist?(path)).to eq(true)
      Freql::BinData.read_msgpack_gz(path) do |saved_data|
        expect(saved_data).to eq(subject)
      end
    end

    it "can .remove_non_words!" do
      subject.remove_non_words!
      is_expected.to eq([[],['one'],[],['three'],['four']])
    end
  end


end


RSpec.describe String do
  context ".valid_word?" do
    it {expect("1234".valid_word?).to eq(false)}
    it {expect("1hundred".valid_word?).to eq(false)}
    it {expect("two words".valid_word?).to eq(false)}
    it {expect("bcdfghjklmnpqrstvwxz".valid_word?).to eq(false)}
    it {expect("www.example.com".valid_word?).to eq(false)}
    it {expect("@username".valid_word?).to eq(false)}
    it {expect("bat's".valid_word?).to eq(true)}
    it {expect("Capital".valid_word?).to eq(true)}
    it {expect("a".valid_word?).to eq(true)}
    it {expect("I".valid_word?).to eq(true)}
  end
end
