# frozen_string_literal: true
require 'econfig'
require 'minitest/autorun'
require_relative '../lib/init.rb'


extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = File.expand_path('../../', File.expand_path(__FILE__))
