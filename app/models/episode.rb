class Episode < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :description }
  validates :episode_num, presence: true, uniqueness: true
end
