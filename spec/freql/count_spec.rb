# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Freql::Count do

  context '.add_words("one two two three three three")' do
    subject do 
      Freql::Count.new().add_words('one two two three three three')
    end

    it('.tokens counts the words') {expect(subject.tokens).to eq({'one'=>1,'two'=>2,'three'=>3})}
    it('.total == 6') {expect(subject.total).to eq(6)}

    it('can continue from another source') do
      subject.add_words('one two four four four four')
      expect(subject.tokens).to eq({'one'=>2,'two'=>3,'three'=>3,'four'=>4})
      expect(subject.total).to eq(12)
    end
  end

  context '.add_array(["one", "two", "two", "three", "three", "three"])' do
    subject do 
      Freql::Count.new().add_array(["one", "two", "two", "three", "three", "three"])
    end
    
    it('.tokens counts the words') {expect(subject.tokens).to eq({'one'=>1,'two'=>2,'three'=>3})}
    it('.total == 6') {expect(subject.total).to eq(6)} 
  end


end
 
