class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = 'CJGCTTS3OQAQZO2XI2TWVB0TY0WH0FJHRF4S2E1QKCJ1HVFH'
      req.params['client_secret'] = 'VSTNKEYLJPEBCQZQKQ4UCADWSQCHVZFZ5EKKCTPMKU1RJTFZ'
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
