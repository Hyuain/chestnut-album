class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :open_id, null: false
      t.integer :role

      t.timestamps
    end
  end
end
