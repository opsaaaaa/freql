# frozen_string_literal: true
RSpec.describe Freql::FPMW do
  subject { Freql::FPMW }
  {
    to_fq: {
      MILLION => 1,
      0 => 0,
      (MILLION/2) => 0.5,
    },
    to_fpbw: {
      MILLION => BILLION,
      0 => 0,
      MILLION / 2 => BILLION / 2,
    },
    to_zipf: {
      MILLION => 9,
      100 => 5,
      0.01 => 1,
    },
    to_cb: {
      MILLION => 0,
      100 => -400,
      0.01 => -800,
    }
  }.each do |fuc, samples|
    context fuc do
      samples.each do |key, val|
        it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
      end
    end
  end
end

