require_relative 'bindata'
require_relative 'cb'

module Freql
  class Words

    # This is for looking up the word frequencey in various languages

    attr_reader :words

    def initialize lang: :en, size: :small
      @lang = lang
      @size = size
      extract_lang_file
    end

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

    def extract_lang_file
      BinData.read_and_unpack_lang( @lang, size: @size ) do |lang_data|
        @words = lang_data
      end
    end
  end
end
