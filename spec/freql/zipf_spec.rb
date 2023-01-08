# frozen_string_literal: true
RSpec.describe Freql::ZipF do
  subject { Freql::ZipF }
  {
    to_fq: {
      9 => 1,
      1 => 1.0e-08,
    },
    to_fpmw: {
      9 => MILLION,
      1 => 0.01,
    },
    to_fpbw: {
      9 => BILLION,
      1 => 10,
    },
    to_cb: {
      9 => 0,
      1 => -800,
    }
  }.each do |fuc, samples|
    context fuc do
      samples.each do |key, val|
        it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
      end
    end
  end
end

