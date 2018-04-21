class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :photo_id
      t.references :user
      t.references :photo

      t.timestamps
    end
  end
end
