class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :release_date
      t.text :description
      t.decimal :rating
      t.string :picture
      t.integer :episode_count
      t.integer :season

      t.timestamps
    end
  end
end
