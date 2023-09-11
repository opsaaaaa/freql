#!/usr/bin/env ruby
# frozen_string_literal: true

# useage:
#   ./bin/extract_lang.rb en,jp small path/to/folder/

# Extract a lang file into human readable txt version where the line number
# represents the positive cB word frequencey

# TODO: this is useful enough, perhaps it should be included in a freql commandline utility.

require "bundler/setup"
require 'freql/bindata'
require 'pry'

size = ARGV[1] || :small
(ARGV[0] || 'en').split(',').each do |lang|
  path = File.join(ARGV[2] || 'tmp', "%s_%s.txt" % [size, lang])
  bin = Freql::BinData.read_lang(lang, size: size)
  bin.write_txt(path)
end

