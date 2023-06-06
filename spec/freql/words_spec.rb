# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Freql::Words do

  context "can check single words with .lookup" do
    subject { Freql::Words.new(lang: :en) }

    it('the > 127') {expect(subject.lookup('the')).to eq(127)}
    it('word > 374') {expect(subject.lookup('word')).to eq(374)}
    it('atotallywrongword > nil') {expect(subject.lookup('atotallywrongword')).to eq(nil)}

    it('the > 127') {expect(subject.lookup_zipf('the')).to eq(7.73)}
    it('word > 374') {expect(subject.lookup_zipf('word')).to eq(5.26)}
    it('atotallywrongword > nil') {expect(subject.lookup_zipf('atotallywrongword')).to eq(nil)}

    context "lang: :es" do
      subject { Freql::Words.new(lang: :es) }
      it('que > 148') {expect(subject.lookup('que')).to eq(148)}
    end
  end

  context "can select multiple words with .query" do
    it {expect(subject.query('the', 'word', 'frequencies', 'atotallywrongword')).to eq(
      {"frequencies"=>526, "the"=>127, "word"=>374}
    )}
  end

end
