class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|
      t.text :title
      t.integer :user_id
      t.string :image_id
      t.text :body

      t.timestamps
    end
  end
end
