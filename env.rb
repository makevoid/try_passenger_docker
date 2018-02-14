require 'bundler'
APP_ENV = ENV["RACK_ENV"].to_sym || :development
Bundler.require :default, APP_ENV
