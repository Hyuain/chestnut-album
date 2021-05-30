require 'http'

class SessionsController < ApplicationController
  def create
    p params
    response = HTTP.get(
      "https://api.weixin.qq.com/sns/jscode2session",
      params: {
        appid: ENV['APP_ID'],
        secret: ENV['APP_SECRET'],
        js_code: params[:code],
        grant_type: "authorization_code",
      }
    )
    p response.body.to_s
  end

  def failure

  end

  def destroy

  end
end
