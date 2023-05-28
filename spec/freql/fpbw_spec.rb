# frozen_string_literal: true
RSpec.describe Freql::FPBW do
  subject { Freql::FPBW }
  {
    to_fq: {
      BILLION => 1,
      0 => 0,
      BILLION/2 => 0.5,

    },
    to_fpmw: {
      BILLION => MILLION,
      0 => 0,
      BILLION / 2 => MILLION / 2,
    },
    to_zipf: {
      BILLION => 9,
      MILLION => 6,
      10 => 1,
    },
    to_cb: {
      BILLION => 0,
      MILLION => -300,
      10 => -800,
    }
  }.each do |fuc, samples|
    context fuc do
      samples.each do |key, val|
        it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
      end
    end
  end

  context 'calc' do
    it('calc(1, 2) => BILLION/2') {expect(subject.calc(1,2)).to eq(BILLION/2)}
    it('calc(0, 3) => 0.0') {expect(subject.calc(0,3)).to eq(0)}
    it('calc(5, 5) => BILLION') {expect(subject.calc(5,5)).to eq(BILLION)}
  end

end

