#!/usr/bin/env ruby
# frozen_string_literal: true

# useage:
#   ./bin/compile_plain_lang.rb en,jp small

# Create a bindata langauge file without non_words like '000'

require "bundler/setup"
require 'freql/bindata'
require 'pry'

size = ARGV[1] || :large
(ARGV[0] || 'en').split(',').each do |lang|
  bin = Freql::BinData.read_lang(lang, size: size)
  bin.remove_non_words!
  bin.write_lang(:en, size: :plain)
end

