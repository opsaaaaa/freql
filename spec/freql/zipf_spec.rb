# frozen_string_literal: true
require 'freql/zipf'

RSpec.describe Freql::ZipF do
  subject { Freql::ZipF }
  {
    zipf_to_fq: {
      9 => 1,
      1 => 1.0e-08,
    },
    zipf_to_fpmw: {
      9 => MILLION,
      1 => 0.01,
    },
    zipf_to_fpbw: {
      9 => BILLION,
      1 => 10,
    },
    zipf_to_cb: {
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

  context 'calc_zipf' do
    it('calc_zipf(1, MILLION) => 3.0') {expect(subject.calc_zipf(1,MILLION)).to eq(3.0)}
    it('calc_zipf(100, MILLION) => 5.0') {expect(subject.calc_zipf(100,MILLION)).to eq(5.0)}
    it('calc_zipf(MILLION, MILLION) => 9.0') {expect(subject.calc_zipf(MILLION,MILLION)).to eq(9.0)}
    # zipf pf can technically go negative with rare enough words/tokens.
    it('calc_zipf(0.1, BILLION) => -1.0') {expect(subject.calc_zipf(0.1,BILLION)).to eq(-1.0)}
  end


end

