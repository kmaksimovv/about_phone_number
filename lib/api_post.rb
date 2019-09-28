# frozen_string_literal: true

require 'json'

require 'net/http'

class ApiPost
  API_URL = 'https://cleaner.dadata.ru/api/v1/clean/phone'

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def params
    [number.to_s].to_s
  end

  def headers(request)
    request['Authorization'] = 'Token ' + ENV['API_KEY']
    request['Content-Type'] = 'application/json'
    request['X-Secret'] = ENV['SECRET_KEY']
  end

  def call
    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    headers request
    request.body = params
    response = http.request(request).body
    JSON.parse(response)
  end
end
