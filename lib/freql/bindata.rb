require 'zlib'
require 'msgpack'

module Freql
  module BinData

    # BinData is a tool for compressing key=>integer pair data
    # into an array where the place of the index stores the integer value.

    # {'three' => 3} > [[],[],[],['three']]

    # its use in the [wordfq](https://github.com/rspeer/wordfq) program
    # to compress word frequency data.


    LANG_FILE_PATH = "lib/freql/data/%s_%s.msgpack.gz"

    class << self

      def pack hash_data, size: nil
        size ||= hash_data.values.max
        bin_data = Array.new(size+1) { [] }

        hash_data.each do |key, val|
          bin_data[val.to_i] << key
        end

        return bin_data
      end

      def unpack bin_data
        hash_data = {}
        bin_data.each.with_index do |group, val|
          group.each do |key|
            hash_data[key] = val
          end
        end
        return hash_data
      end

      def read_lang lang = :en, size: :small, &block
        Zlib::GzipReader.open(LANG_FILE_PATH % [size,lang]) do |gz|
          # The first item in the language data contains version and format information
          # Im choosing to ignore that information for now.
          # The rest of the data is word frequency bindata
          block.call MessagePack.unpack(gz.read)[1..]
        end
      end

      def read_and_unpack_lang lang = :en, size: :small, &block
        read_lang(lang, size: size) {|data| block.call( unpack(data) ) }
      end
    end
  end
end
