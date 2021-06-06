class UserAlbumRelationsController < ApplicationController
  def create
    UserAlbumRelation.create album_id: params[:album_id], user_id: params[:user_id], authority: params[:authority]
  end
end
