class Movie < ApplicationRecord
  has_many :movie_reviews
  validates :title,    presence: true, length: { maximum: 50 },
                       uniqueness: true
  validates :genre, presence: true
  validates :director, presence: true
end
