class Node < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :is_favorite, inclusion: { in: [true, false] }
end
