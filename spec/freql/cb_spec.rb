# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Freql::CB do
  subject { Freql::CB }
  {
    to_fq: {
      0 => 1,
      -800 => 1.0e-08,
    },
    to_fpmw: {
      0 => MILLION,
      -800 => 0.01,
    },
    to_fpbw: {
      0 => BILLION,
      -800 => 10,
    },
    to_zipf: {
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
end

