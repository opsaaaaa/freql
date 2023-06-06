
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
      @total += source.length
      source.each do |token|
        add_token(token)
      end
      self
    end

    def add_words source
      add_matches(source, /\w+/)
    end

    def add_single_token token
      @total += 1
      add_token(token)
    end

    def add_matches source, pattern
      add_array(source.scan(pattern))
    end

    def add_inflated_pairs source, size = 2
      out = []
      for x in 0..(source.length-size) do
        out << source[x...x+size]
      end
      add_array(out)
    end

    def compute_cb
      @total = @total.to_f
      tokens.transform_values {|count| CB.calc_cb(count,@total)}
    end

    def compute_zipf
      @total = @total.to_f
      tokens.transform_values {|count| ZipF.calc_zipf(count,@total)}
    end

    def compute_bindata
      BinData.pack(tokens.transform_values {|count| CB.calc_cb(count,@total).abs.round})
    end


    private

    def add_token token
      if @tokens.has_key?(token)
        @tokens[token] += 1
      else
        @tokens[token] = 1
      end
    end



  end
end
