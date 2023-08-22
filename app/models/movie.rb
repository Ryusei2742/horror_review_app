class Movie < ApplicationRecord
  has_many :movie_reviews
  validates :title,    presence: true, length: { maximum: 50 },
                       uniqueness: true
  validates :genre, presence: true
  validates :director, presence: true
  scope :by_director, ->(director) { where(director: director) }
  scope :by_genre, ->(genre) { where(genre: genre) }
  scope :by_cast, ->(cast) { where(cast: cast) }

  def calculate_average_rating
    if reviews.count > 0
      total_rating = reviews.sum(:rating)
      self.average_rating = total_rating.to_f / reviews.count
      save
    end
  end

  scope :filtered_and_ordered, ->(params) {
    filtered(params[:director], params[:genre], params[:cast])
      .ordered_by_rating(params[:rating])
  }

  scope :filtered, ->(director, genre, cast) {
    filtered = all
    filtered = filtered.where(director: director) if director.present?
    filtered = filtered.where(genre: genre) if genre.present?
    filtered = filtered.where(cast: cast) if cast.present?
    filtered
  }

  scope :ordered_by_rating, ->(rating) {
    case rating
    when 'asc'
      order(rating: :asc)
    when 'desc'
      order(rating: :desc)
    else
      all
    end
  }
end
