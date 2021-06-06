require 'upload_oss_helper'

class PhotosController < ApplicationController
  def get_pre_oss_info
    file_name = params[:file_name]
    file_name ||= 'haha'
    upload_helper = UploadOssHelper.new file_name: file_name
    render_resource upload_helper.create_upload_params
  end
end
