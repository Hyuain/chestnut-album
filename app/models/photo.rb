class Photo < ApplicationRecord
  paginates_per 10

  belongs_to :album, required: true
end
