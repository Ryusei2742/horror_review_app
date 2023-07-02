class Movie < ApplicationRecord
  validates :title,    presence: true, length: { maximum: 50 },
                       uniqueness: true
  validates :category, presence: true
  validates :director, presence: true
  validates :rating,   presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
