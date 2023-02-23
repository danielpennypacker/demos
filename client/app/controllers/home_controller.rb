class HomeController < ApplicationController
  def new
    require 'net/http'

    puts 'client === sending message ===='


    puts 'client === RSA Example ===='
    payload = {hi: 'there'}
    rsa_private = OpenSSL::PKey::RSA.generate 2048
    rsa_public = rsa_private.public_key
    token = JWT.encode payload, rsa_private, 'PS256'
    puts token
    decoded_token = JWT.decode token, rsa_public, true, { algorithm: 'PS256' }
    puts decoded_token


    # Example with HMAC, i.e. a secret.
    puts 'client === HMAC Example ===='
    hmac_secret = 'super-secret'
    token = JWT.encode payload, hmac_secret, 'HS256'
    puts token

    decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }

    # Array
    # [
    #   {"data"=>"test"}, # payload
    #   {"alg"=>"HS256"} # header
    # ]
    puts decoded_token


    url = URI.parse("http://localhost:3001/home/new")
    req = Net::HTTP::Get.new(url.to_s)
    req['blah-token'] = token
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.code

  end
end
