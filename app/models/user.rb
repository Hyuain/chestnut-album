class User < ApplicationRecord
  has_many :user_album_relations
  has_many :albums, through: :user_album_relations
end
