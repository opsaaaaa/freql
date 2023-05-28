# frozen_string_literal: true
RSpec.describe Freql::FQ do
  subject { Freql::FQ }
  {
    to_fpmw: {
      1 => MILLION,
      0 => 0,
      0.5 => MILLION/2
    },
    to_fpbw: {
      1 => BILLION,
      0 => 0,
      0.5 => BILLION/2
    },
    to_zipf: {
      1 => 9,
      0.1 => 8,
      0.01 => 7,
      0.00000001 => 1,
      0.000000001 => 0,
      0.0000000001 => -1,
    },
    to_cb: {
      1 => 0,
      0.001 => -300,
      0.0000001 => -700,
    },
  }.each do |fuc, samples|
    context fuc do
      samples.each do |key, val|
        it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
      end
    end
  end

  context 'calc' do
    it('calc(1, 2) => 0.5') {expect(subject.calc(1,2)).to eq(0.5)}
    it('calc(0, 3) => 0.0') {expect(subject.calc(0,3)).to eq(0.0)}
    it('calc(5, 5) => 1.0') {expect(subject.calc(5,5)).to eq(1.0)}
  end

end

