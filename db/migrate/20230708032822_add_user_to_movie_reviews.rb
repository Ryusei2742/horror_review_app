class AddUserToMovieReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :movie_reviews, :user, null: false, foreign_key: true
  end
end
