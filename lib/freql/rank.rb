require_relative 'bindata'
require_relative 'cb'

module Freql
  class Rank

    # lookup the word rank for given words/tokens.

    class << self
      def by_lang lang, size: :small
        rank = self.new
        rank.extract_lang_file lang, size: size
        return rank
      end
    end

    attr :ranks

    def lookup rank
      @ranks[rank-1]
    end

    def top_n rank
      @ranks[0...rank]
    end

    def extract_lang_file lang, size:
      BinData.read_lang( lang, size: size ) do |lang_data|
        # @ranks = lang_data.filter {|group| !group.empty? }
        # some words really should have the same ranking as the score is the same.
        # for now ignore that detail and build a simple flat list.
        # Its also wirth noting that the data contains non-words like 000.
        @ranks = lang_data.flatten
      end
    end
  end
end


