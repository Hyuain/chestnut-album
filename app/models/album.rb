class Album < ApplicationRecord
  has_many :user_album_relations
  has_many :photos
end
