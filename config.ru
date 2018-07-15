require 'rubygems'
require 'bundler'
Bundler.require

require './app.rb'

set :public_folder, Proc.new {File.join(root, '_site')}
disable :static

run Sinatra::Application

# Notes
# * Start sinatra app using 'bundle exec rackup config.ru' (this doesn't really work well)
# * Rebuild jekyll site using jekyll --server
# * You cannot use autoserve mode - due to the public directory

