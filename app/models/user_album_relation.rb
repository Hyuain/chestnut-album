class UserAlbumRelation < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :album, required: true

  enum authority: { creator: 1, admin: 2 }
end
