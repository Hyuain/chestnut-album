require 'upload_oss_helper'

class PhotosController < ApplicationController
  def get_pre_oss_info
    filename = params[:filename]
    filename ||= 'haha'
    upload_helper = UploadOssHelper.new filename: filename
    render_resource upload_helper.create_upload_params
  end

  def index
    render_resource page: params[:page].to_i, totalCounts: Photo.count, list: Photo.page(params[:page]).per(params[:size])
  end

  def create
    url = params[:url]
    Photo.create url: url
    render_resource url: url
  end

end
