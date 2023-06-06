# frozen_string_literal: true
require 'spec_helper'
require 'freql/cb'

RSpec.describe Freql::CB do
  subject { Freql::CB }
  {
    cb_to_fq: {
      0 => 1,
      -800 => 1.0e-08,
    },
    cb_to_fpmw: {
      0 => MILLION,
      -800 => 0.01,
    },
    cb_to_fpbw: {
      0 => BILLION,
      -800 => 10,
    },
    cb_to_zipf: {
      0 => 9,
      -800 => 1,
    }
  }.each do |fuc, samples|
    context fuc do
      samples.each do |key, val|
        it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
      end
    end
  end

  context 'calc_cb' do
    # CB can't cross zero.
    # You can invert it and treat it like a positive integer.
    it('calc_cb(MILLION, MILLION) => 0') {expect(subject.calc_cb(MILLION,MILLION)).to eq(0)}
    it('calc_cb(1, MILLION) => -600') {expect(subject.calc_cb(1,MILLION)).to eq(-600)}
    it('calc_cb(100, MILLION) => -400') {expect(subject.calc_cb(100,MILLION)).to eq(-400)}
    it('calc_cb(0.1, BILLION) => -1000') {expect(subject.calc_cb(0.1,BILLION)).to eq(-1000)}
  end


end

