# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Freql::Counter do

  context '.add_words("one two two three three three")' do
    subject do 
      Freql::Counter.new().add_words('one two two three three three')
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
      Freql::Counter.new().add_array(["one", "two", "two", "three", "three", "three"])
    end

    it('.tokens counts the words') {expect(subject.tokens).to eq({'one'=>1,'two'=>2,'three'=>3})}
    it('.total == 6') {expect(subject.total).to eq(6)} 
  end

  context '.compute*' do
    subject do
      Freql::Counter.new( tokens: {'one'=>1,'two'=>10,'three'=>100,'four'=>1000,'five'=>10000}, total: MILLION)
    end
    
    it('_cb frequencey') do
      expect(subject.compute_cb).to eq(
        {'one'=>-600, 'two'=>-500,'three'=>-400,'four'=>-300, 'five'=>-200}
      )
    end
    
    it('_zipf frequencey') do
      expect(subject.compute_zipf).to eq(
        {'one'=>3, 'two'=>4,'three'=>5,'four'=>6, 'five'=>7}
      )
    end

    context '_bindata' do
      subject do
        Freql::Counter.new( 
          tokens: {'one'=>MILLION, '1'=>MILLION, 'two'=>100000, 'three'=>10000},
          total: MILLION
        ).compute_bindata
      end

      it('bindata [0] => ["one", "1"]') {expect(subject[0]).to eq(['one', '1'])}
      it('bindata [100] => ["one"]') {expect(subject[100]).to eq(['two'])}
      it('bindata [200] => ["three"]') {expect(subject[200]).to eq(['three'])}

    end
  end

end
 
