require 'zlib'
require 'msgpack'

module Freql
  class BinData < Array

    # BinData is a tool for compressing key=>integer pair data
    # into an array where the place of the index stores the integer value.

    # {'three' => 3} > [[],[],[],['three']]

    # it is use in the [wordfq](https://github.com/rspeer/wordfq) program to
    # compress word frequency data.

    # The 0'ht item in the language bindata files contains version and format information
    # ie [{"format"=>"cB", "version"=>1},[],[],...]
    # Im choosing to respectfully ignore that information in the code for now.
    # The rest of the data is the word frequency bindata.

    # I am assuming that because a cB of 100% is 0 that the version information shifts
    # the binData index's over by one.

    # TODO: It may be good to throw an error if the version information
    # isn't present in the data.

    LANG_FILE_PATH = "lib/freql/data/%s_%s.msgpack.gz"
    FORMAT_METADATA = {"format"=>"cB", "version"=>1}

    class << self

      def pack hash_data, size: nil
        size ||= hash_data.values.max
        bin_data = BinData.new(size+1) { [] }

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
        read_msgpack_gz(LANG_FILE_PATH % [size,lang],&block)
      end

      def read_msgpack_gz path, &block
        bindata = nil
        Zlib::GzipReader.open(path) do |gz|
          bindata = BinData.new(MessagePack.unpack(gz.read)[1..])
          block.call bindata if block_given?
        end
        bindata
      end

      def read_and_unpack_lang lang = :en, size: :small, &block
        read_lang(lang, size: size) {|data| block.call( unpack(data) ) }
      end

      def write_msgpack_gz path, bindata
        Zlib::GzipWriter.open(path) do |gz|
          gz.write(MessagePack.pack([FORMAT_METADATA] + bindata))
        end
      end

      def write_lang lang, bindata, size: :new
        write_msgpack_gz(LANG_FILE_PATH % [size,lang], bindata)
      end

    end

    def unpack
      BinData.unpack self
    end

    def write_msgpack_gz path
      BinData.write_msgpack_gz(path,self)
    end

    def write_txt path
      File.write(path,self.to_txt)
    end

    def write_lang lang, size:
      BinData.write_lang(lang, self, size: size)
    end

    def filter_bin &block
      self.each.with_index do |group, value|
        group.filter! do |item|
          block.call item, value
        end
      end
    end

    def each_item &block
      self.each.with_index do |group, value|
        group.each do |item|
          block.call item, value
        end
      end
    end

    def remove_non_words!
      filter_bin {|word| word.valid_word? }
    end

    def rank
      self.filter! {|group| !group.empty?}
    end

    def to_txt
      self.map {|i| i.join ' ' }.join("\n")
    end

  end
end

class String
  def valid_word? 
    self.match?(/[aeiouyAEIOUY]/) && !self.match?(/[^A-z']|[_]/)
  end
end
