class MoviesController < ApplicationController
  before_action :admin_user, only: :destroy

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.movie_reviews
    @average_rating = @reviews.average(:rating)
  end

  def index
    @movies = Movie.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @movie = Movie.find(params[:id]).destroy
    @movie.destroy
    flash[:success] = "削除しました"
    redirect_to movies_url, status: :see_other
  end

  def search
    if params[:search].present?
      keywords = "%#{params[:search]}%"
      # 検索条件に基づいて映画を検索する
      @movies = Movie.where("title LIKE ? OR genre LIKE ? OR director LIKE ? OR cast LIKE ?", keywords, keywords, keywords, keywords)
    else
      # 検索条件が指定されていない場合は全ての映画を表示する
      @movies = Movie.all
    end
  end

  private

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
