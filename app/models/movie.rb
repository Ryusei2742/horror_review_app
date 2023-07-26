class Movie < ApplicationRecord
  has_many :movie_reviews
  validates :title,    presence: true, length: { maximum: 50 },
                       uniqueness: true
  validates :genre, presence: true
  validates :director, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
