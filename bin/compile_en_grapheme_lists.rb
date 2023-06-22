#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require 'freql/bindata'
require 'freql/counter'
require 'pry'

CUTTOFF = 300

[1,2,3].each do |token_size|
  counter = Freql::Counter.new
  bin = Freql::BinData.read_lang(:en, size: :small)
  bin.remove_non_words!

  bin.each_item do |item, cb|
    counter.add_inflated_pairs(item, token_size)
  end

  graphemes = counter.compute_bindata
  
  graphemes.slice!(CUTTOFF..)

  graphemes.write_lang(:en, size: "graphemes_#{token_size}")
  puts "worte #{token_size} graphemes pack"

  File.write("tmp/graphemes_#{token_size}.txt", graphemes.map {|i| i.join ' ' }.join("\n"))
end

