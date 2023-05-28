
module Freql
  class Counter

    # Calculate word/token frequencies from various inputs

    # class << self
    # end

    attr :total
    attr :tokens

    def initialize tokens: {}, total: 0
      @tokens = tokens
      @total = total
    end

    def add_array source
      source.each do |token|
        add_token(token)
      end
      self
    end

    def add_words source
      source.scan(/\w+/) do |word|
        add_token(word)
      end
      self
    end

    def add_token token
      @total += 1
      if @tokens.has_key?(token)
        @tokens[token] += 1
      else
        @tokens[token] = 1
      end
    end

    def compute_cb
      @total = @total.to_f
      tokens.transform_values {|count| CB.calc(count,@total)}
    end

    def compute_zipf
      @total = @total.to_f
      tokens.transform_values {|count| ZipF.calc(count,@total)}
    end

    def compute_bindata
      BinData.pack(tokens.transform_values {|count| CB.calc(count,@total).abs.round})
    end


  end
end
