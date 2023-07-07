class CreateMovieReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_reviews do |t|
      t.text :content
      t.integer :rating
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
