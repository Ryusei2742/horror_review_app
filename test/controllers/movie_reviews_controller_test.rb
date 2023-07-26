require 'test_helper'

class MovieReviewsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @movie = movies(:movie1)
    @review = movie_reviews(:movie_review_1)
  end

  test "logged-in user can create a movie review" do
    user = users(:michael)
    log_in_as(user)

    review_content = "これはとても面白い映画でした！"
    review_rating = 4
    movie_id = movies(:movie1).id

    post movie_reviews_path, params: { movie_review: { content: review_content, rating: review_rating, movie_id: movie_id } }

    assert_difference 'MovieReview.count', 1 do
      post movie_reviews_path, params: { movie_review: { content: review_content, rating: review_rating, movie_id: movie_id } }
    end

    # レビューが正しく保存されたかを確認
    assert_redirected_to movie_path(movie_id) # レビューを投稿した後に映画ページにリダイレクトされるかを確認
    assert_equal review_content, MovieReview.last.content # 最後に作成されたレビューの内容がテスト用データと一致するかを確認
    assert_equal review_rating, MovieReview.last.rating # 最後に作成されたレビューの評価値がテスト用データと一致するかを確認
    assert_equal user.id, MovieReview.last.user_id # 最後に作成されたレビューのユーザーIDがログインしているユーザーのIDと一致するかを確認
    assert_equal movie_id, MovieReview.last.movie_id # 最後に作成されたレビューの映画IDがテスト用データと一致するかを確認

    # レビューの内容が空欄の場合保存されないことを確認
    assert_no_difference 'MovieReview.count' do
      post movie_reviews_path, params: { movie_review: { content: "", rating: review_rating, movie_id: movie_id } }
    end

    # 評価値が1未満の場合、保存されないことを確認
    assert_no_difference 'MovieReview.count' do
      post movie_reviews_path, params: { movie_review: { content: review_content, rating: 0, movie_id: movie_id } }
    end

    # 評価値が5より大きい場合、保存されないことを確認
    assert_no_difference 'MovieReview.count' do
      post movie_reviews_path, params: { movie_review: { content: review_content, rating: 6, movie_id: movie_id } }
    end
  end

  test "redirects to login page for non-logged-in user trying to create movie review" do
    review_content = "これはとても面白い映画でした！"
    review_rating = 4
    movie_id = movies(:movie1).id

    assert_no_difference 'MovieReview.count' do
      post movie_reviews_path, params: { movie_review: { content: review_content, rating: review_rating, movie_id: movie_id } }
    end

    assert_redirected_to login_url
  end

  test "movie page should show associated reviews" do
    user = users(:michael)
    log_in_as(user)
    # テスト用の映画とレビューを作成
    movie = movies(:movie1)
    review1 = movie_reviews(:movie_review_1)
    review2 = movie_reviews(:movie_review_2)

    # 映画ページをGETリクエスト
    get movie_path(movie)

    # レビューの内容が表示されているかを確認
    assert_match review1.content, response.body
    assert_match review2.content, response.body
  end

  test "logged-in user can edit own review" do
    log_in_as(@user)

    get edit_movie_review_path(@review)
    assert_response :success

    patch movie_review_path(@review), params: { movie_review: { content: "更新したcontent", rating: 5 } }
    assert_redirected_to movie_review_path(@review)
    @review.reload
    assert_equal "更新したcontent", @review.content
    assert_equal 5, @review.rating
  end

  test "non-logged-in user should not be able to edit review" do
    get edit_movie_review_path(@review)
    assert_redirected_to login_path
  end

  test "logged-in user should not be able to edit other user's review" do
    log_in_as(@other_user)

    get edit_movie_review_path(@review)
    assert_redirected_to movie_path(@movie)

    patch movie_review_path(@review), params: { movie_review: { content: "更新されたcontent", rating: 1 } }
    assert_redirected_to movie_path(@movie)
    @review.reload
    assert_not_equal "更新されたcontent", @review.content
    assert_not_equal 1, @review.rating
  end
end
