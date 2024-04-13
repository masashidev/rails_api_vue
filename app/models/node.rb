class Node < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :is_favorite, inclusion: { in: [true, false] }
  belongs_to :category, optional: true
end
