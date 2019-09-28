require 'dotenv/load'
require 'sinatra/base'
require './lib/api_post'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  
  get '/' do
    erb :form
  end

  get '/show' do
    number = params[:number]
    response = ApiPost.new(number).call

    @json = response.first

    erb :show
  end
end
