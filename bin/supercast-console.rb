#!/usr/bin/env ruby

# frozen_string_literal: true

require "irb"
require "irb/completion"

require "#{::File.dirname(__FILE__)}/../lib/supercast"

# Config IRB to enable --simple-prompt and auto indent
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

puts "Loaded gem 'supercast'"

IRB.start
