class AddSpoilerToMovieReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_reviews, :spoiler, :boolean, default: false
  end
end
