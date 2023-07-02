class AddIndexToMoviesTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :movies, :title, unique: true
  end
end
