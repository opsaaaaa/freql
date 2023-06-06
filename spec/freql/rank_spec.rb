# frozen_string_literal: true
require 'spec_helper'
require 'freql/rank'

RSpec.describe Freql::Rank do
  subject { Freql::Rank.by_lang(:en) }

  context "can check rank with .lookup" do
    it('1 > the') {expect(subject.lookup(1)).to eq('the')}
    it('10 > that') {expect(subject.lookup(10)).to eq('that')}
  end

  context "can get the .top_n" do
    it('') {expect(subject.top_n(10)).to eq(
      ["the", "to", "and", "of", "a", "in", "i", "is", "for", "that"]
    )}
  end


end
