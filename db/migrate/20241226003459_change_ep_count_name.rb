class ChangeEpCountName < ActiveRecord::Migration[8.0]
  def change
    rename_column :episodes, :episode_count, :episode_num
  end
end
