#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require 'freql/bindata'
require 'pry'

bin = Freql::BinData.read_lang(:en, size: :large)
bin.remove_non_words!
bin.write_lang(:en, size: :plain)


