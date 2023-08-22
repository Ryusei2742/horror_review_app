class MovieReview < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  after_create :update_movie_average_rating

  def update_movie_average_rating
    movie.calculate_average_rating
  end
end
