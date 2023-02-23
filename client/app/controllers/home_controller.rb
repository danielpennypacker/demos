class HomeController < ApplicationController
  def new

    puts 'client === sending message ===='

    require 'net/http'

    url = URI.parse('http://localhost:3001/home/new')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.code

  end
end
