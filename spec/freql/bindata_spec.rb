# frozen_string_literal: true
RSpec.describe Freql::BinData do
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

