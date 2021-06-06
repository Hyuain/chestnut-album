class CreateUserAlbumRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_album_relations do |t|
      t.references :album, null: false
      t.references :user, null: false
      t.integer :authority, null: false

      t.timestamps
    end
  end
end
