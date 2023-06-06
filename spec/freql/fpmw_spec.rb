# frozen_string_literal: true
require 'freql/fpmw'

RSpec.describe Freql::FPMW do
  subject { Freql::FPMW }
  {
    fpmw_to_fq: {
      MILLION => 1,
      0 => 0,
      (MILLION/2) => 0.5,
    },
    fpmw_to_fpbw: {
      MILLION => BILLION,
      0 => 0,
      MILLION / 2 => BILLION / 2,
    },
    fpmw_to_zipf: {
      MILLION => 9,
      100 => 5,
      0.01 => 1,
    },
    fpmw_to_cb: {
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

  context 'calc_fpmw' do
    it('calc_fpmw(1, 2) => MILLION/2') {expect(subject.calc_fpmw(1,2)).to eq(MILLION/2)}
    it('calc_fpmw(0, 3) => 0.0') {expect(subject.calc_fpmw(0,3)).to eq(0)}
    it('calc_fpmw(5, 5) => MILLION') {expect(subject.calc_fpmw(5,5)).to eq(MILLION)}
  end


end

