require 'http'

class SessionsController < ApplicationController
  def create
    response = HTTP.get(
      "https://api.weixin.qq.com/sns/jscode2session",
      params: {
        appid: ENV['APP_ID'],
        secret: ENV['APP_SECRET'],
        js_code: params[:code],
        grant_type: "authorization_code",
      }
    )
    body = JSON.parse(response.body.to_s)
    s = Session.new open_id: body['openid']
    s.validate
    current_user = s.user.nil? ? (User.create open_id: s.open_id) : s.user
    session[:current_user_id] = current_user.id
    p "----------------"
    p session
    render_resource id: current_user.id
  end

  def test
    p "intest!!!!!"
    p session[:current_user_id]
  end

  def destroy
    session[:current_user_id] = nil
    head :ok
  end
end
