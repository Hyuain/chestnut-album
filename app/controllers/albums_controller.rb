class AlbumsController < ApplicationController
  before_action :must_sign_in

  def index
    list = @current_user.user_album_relations.map{ |ua| { id: ua.album.id , name: ua.album.name } }
    render_resource list: list
  end

  def create
    name = params[:name]
    album = Album.create name: name
    UserAlbumRelation.create album: album, user: @current_user, authority: :creator
    render_resource name: name
  end

end
