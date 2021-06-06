class AlbumsController < ApplicationController

  def index
  end

  def create
    name = params[:name]
    Album.create name: name
    render_resource name: name
  end

end
