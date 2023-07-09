class AddTitleToMovieReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_reviews, :title, :string
  end
end
