class MovieReviewsController < ApplicationController

  def create
    @movie_review = MovieReview.new(movie_review_params)

    if @movie_review.save
      redirect_to movie_path(@movie_review.movie, notice: 'レビューが投稿されました。')
    else
      redirect_back(fallback_location: root_path, alert: 'レビューの投稿に失敗しました。')
    end
  end

  def show
    @movie_review = MovieReview.find(params[:id])
  end

  def index
    @movie_review = MovieReview.all
  end

  private

  def movie_review_params
    params.permit(:content, :rating, :movie_id)
  end
end
