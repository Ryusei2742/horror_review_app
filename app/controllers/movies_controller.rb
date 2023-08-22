class MoviesController < ApplicationController
  before_action :admin_user, only: :destroy

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.movie_reviews
    @average_rating = @reviews.average(:rating)
  end

  def index
    @movies = Movie.filtered_and_ordered(params).paginate(page: params[:page], per_page: 10)
    @directors = Movie.distinct.pluck(:director).sort_by(&:to_s)
    @genres = Movie.distinct.pluck(:genre).sort_by(&:to_s)
    @casts = Movie.distinct.pluck(:cast).sort_by(&:to_s)

    if params[:director].present?
      @movies = @movies.by_director(params[:director])
    end

    if params[:genre].present?
      @movies = @movies.by_genre(params[:genre])
    end

    if params[:cast].present?
      @movies = @movies.by_cast(params[:cast])
    end

    if params[:order_by] == 'rating'
      @movies = @movies.order(average_rating: :desc)
    end
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
