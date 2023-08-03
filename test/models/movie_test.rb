require "test_helper"

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "Sample Movie", genre: "Action", director: "John Doe", rating: 4)
  end

  test "should be valid" do
    assert @movie.valid?
  end

  test "title should be present" do
    @movie.title = "     "
    assert_not @movie.valid?
  end

  test "genre should be present" do
    @movie.genre = "     "
    assert_not @movie.valid?
  end

  test "director should be present" do
    @movie.director = "     "
    assert_not @movie.valid?
  end

  test "title should not be too long" do
    @movie.title = "a" * 51
    assert_not @movie.valid?
  end

  test "movie title should be unique" do
    duplicate_movie = @movie.dup
    @movie.save
    assert_not duplicate_movie.valid?
  end
end
