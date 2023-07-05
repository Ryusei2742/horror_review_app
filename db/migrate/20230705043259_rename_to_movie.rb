class RenameToMovie < ActiveRecord::Migration[7.0]
  def change
    rename_column :movies, :category, :genre
    add_column :movies, :cast, :string
    change_column :movies, :rating, :float
  end
end
