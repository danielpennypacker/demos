class HomeController < ApplicationController
  def new
    token = request.headers["blah-token"]

    puts 'provider ----- token '
    puts token
    hmac_secret = 'super-secret'
    decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }

    puts 'provider ---- decoded token -----'
    puts decoded_token
  end
end
