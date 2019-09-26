# frozen_string_literal: true

require 'json'

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
    request['Authorization'] = 'Token d1665bd9346b792fd1b125b46b0e22800c228743'
    request['Content-Type'] = 'application/json'
    request['X-Secret'] = '74c8204738e31d7b6515d3adbc78a29607745d37'
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
