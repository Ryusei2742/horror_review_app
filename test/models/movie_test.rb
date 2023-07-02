require "test_helper"

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "Example User", category: "Example",
                       director: "Example", rating: "3")
  end

  test "should be valid" do
    assert @movie.valid?
  end

  test "title should be present" do
    @movie.title = "     "
    assert_not @movie.valid?
  end

  test "category should be present" do
    @movie.category = "     "
    assert_not @movie.valid?
  end

  test "director should be present" do
    @movie.director = "     "
    assert_not @movie.valid?
  end

  test "rating should be present" do
    @movie.rating = "     "
    assert_not  @movie.valid?
  end

  test "title should not be too long" do
    @movie.title = "a" * 51
    assert_not @movie.valid?
  end

  test "rating should be between 0 and 5" do
    @movie.rating = -1
    assert_not @movie.valid?
    @movie.rating = 6
    assert_not @movie.valid?
  end

  test "movie title should be unique" do
    duplicate_movie = @movie.dup
    @movie.save
    assert_not duplicate_movie.valid?
  end
end
