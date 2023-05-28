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

  context 'calc' do
    it('calc(1, MILLION) => 3.0') {expect(subject.calc(1,MILLION)).to eq(3.0)}
    it('calc(100, MILLION) => 5.0') {expect(subject.calc(100,MILLION)).to eq(5.0)}
    it('calc(MILLION, MILLION) => 9.0') {expect(subject.calc(MILLION,MILLION)).to eq(9.0)}
    # zipf pf can technically go negative with rare enough words/tokens.
    it('calc(0.1, BILLION) => -1.0') {expect(subject.calc(0.1,BILLION)).to eq(-1.0)}
  end


end

