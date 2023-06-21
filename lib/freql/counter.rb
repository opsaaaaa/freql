
require_relative 'zipf'
require_relative 'cb'

module Freql
  class Counter < Hash

    # Calculate word/token frequencies from various inputs provided.

    def add_array source
      source.each do |token|
        add_token(token)
      end
      self
    end

    def add_words source
      add_matches(source, /\w+/)
    end

    def add_single_token token
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
      self.transform_values {|count| CB.calc_cb(count,total.to_f)}
    end

    def compute_zipf
      self.transform_values {|count| ZipF.calc_zipf(count,total.to_f)}
    end

    def compute_bindata
      BinData.pack(self.transform_values {|count| CB.calc_cb(count,total.to_f).abs.round})
    end

    def total
      self.sum {|k,v| v}
    end

    private

    def add_token token
      if self.has_key?(token)
        self[token] += 1
      else
        self[token] = 1
      end
    end



  end
end
