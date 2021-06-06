require 'upload_oss_helper'
require 'get_oss_helper'

class PhotosController < ApplicationController
  before_action :must_sign_in

  def get_pre_oss_info
    filename = params[:filename]
    filename ||= 'haha'
    upload_helper = UploadOssHelper.new filename: filename
    render_resource upload_helper.create_upload_params
  end

  def index
    get_image_helper = GetOssHelper.new
    photos = Photo.order("created_at DESC").page(params[:page]).per(params[:size]).map { |item| { url: get_image_helper.get_temp_url(item.url) } }
    render_resource page: params[:page].to_i, totalCounts: Photo.count, list: photos
  end

  def create
    url = params[:url]
    Photo.create url: url
    render_resource url: url
  end

end
