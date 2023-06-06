require_relative 'bindata'
require_relative 'cb'

module Freql
  class Words

    # Lookup the cb or zipf work frequency for given words/tokens

    # Words may not be the best name for this class in the future.

    class << self
      def by_lang lang = :en, size: :small
        w = self.new
        w.extract_lang_file lang, size: size
        return w
      end
    end

    attr :words

    def lookup word
      @words[word]
    end

    def lookup_zipf word
      r = lookup(word)
      r && CB.cb_to_zipf(r)
    end

    def query *words
      @words.slice(*words)
    end

    def query_zipf *words
      query(*words).transform_values {|v| CB.cb_to_zipf(v) }
    end

    def extract_lang_file lang, size:
      BinData.read_and_unpack_lang( lang, size: size ) do |lang_data|
        @words = lang_data
      end
    end
  end
end
