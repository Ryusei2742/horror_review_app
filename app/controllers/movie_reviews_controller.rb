class MovieReviewsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :set_movie_review, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @movie_review = MovieReview.new(movie_review_params)
    @movie_review.user_id = current_user.id

    if @movie_review.save
      redirect_to movie_path(@movie_review.movie_id), notice: 'レビューが投稿されました。'
    else
      redirect_back(fallback_location: root_path, alert: 'レビューの投稿に失敗しました。')
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_review = MovieReview.find(params[:id])
  end

  def index
    # @user = User.find(params[:id])
    # @movie_reviews = @user.movie_reviews
    @movie_reviews = MovieReview.includes(:movie, :user).all
  end

  def edit
    @movie_review = MovieReview.find(params[:id])
  end

  def update
    @movie_review = MovieReview.find(params[:id])

    if @movie_review.update(movie_review_params)
      redirect_to @movie_review, notice: 'レビューが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @movie_review = MovieReview.find(params[:id])
    @movie = @movie_review.movie
    @movie_review.destroy
    redirect_to movie_path(@movie), status: :see_other, notice: "レビューが削除されました。"
  end

private

  def movie_review_params
    params.require(:movie_review).permit(:content, :rating, :movie_id, :user_id, :movie_title, :movie_review_id)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'ログインしてください。'
    end
  end

  def set_movie_review
    @movie_review = MovieReview.find(params[:id])
  end

  def correct_user
    unless @movie_review.user == current_user
      flash[:danger] = "このレビューの編集・削除は許可されていません。"
      redirect_to movie_path(@movie_review.movie)
    end
  end
end
