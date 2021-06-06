require 'upload_oss_helper'
require 'get_oss_helper'
require 'custom_error'

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
    album = Album.find_by_id params[:albumId]
    x = album.user_album_relations.find_by user_id: @current_user.id
    if x.nil?
      raise CustomError::AuthorizationError
    end
    photos = album.photos.order("created_at DESC").page(params[:page]).per(params[:size]).map { |item| { url: get_image_helper.get_temp_url(item.url) } }
    render_resource page: params[:page].to_i, totalCounts: album.photos.count, list: photos
  end

  def create
    url = params[:url]
    album_id = params[:albumId]
    Photo.create url: url, album_id: album_id
    render_resource url: url, album_id: album_id
  end

end
