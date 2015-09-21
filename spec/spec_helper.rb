require 'bundler/setup'
Bundler.setup
Bundler.require(:default, :development)

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stats_api'
