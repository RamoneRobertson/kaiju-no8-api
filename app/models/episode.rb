class Episode < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :description }
end
