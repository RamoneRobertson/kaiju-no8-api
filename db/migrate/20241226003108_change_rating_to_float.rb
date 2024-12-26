class ChangeRatingToFloat < ActiveRecord::Migration[8.0]
  def change
    change_column :episodes, :rating, :float
  end
end
