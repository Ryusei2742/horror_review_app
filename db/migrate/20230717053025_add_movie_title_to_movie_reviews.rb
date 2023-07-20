class AddMovieTitleToMovieReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_reviews, :movie_title, :string
  end
end
