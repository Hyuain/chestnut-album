class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :url, null: false
      t.references :album

      t.timestamps
    end
  end
end
