require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load Models
Dir["./app/models/*.rb"].each {|file| require file}

class App < Sinatra::Base
  get '/sinatra' do
    "It's up to you, New York! New Yoooooooooork!!!!"
  end
end
