class MoviesController < ApplicationController
  before_action :admin_user, only: :destroy

  def show
    @movie = Movie.find(params[:id])
  end

  def index
    @movies = Movie.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def destroy
    Movie.find(params[:id]).destroy
    @movie.destroy
    flash[:success] = "削除しました"
    redirect_to movies_url, status: :see_other
  end

  def search
    @keyword = params[:keyword]
    @genre = params[:genre]
    @director = params[:director]
    @cast = params[:cast]

    @movies  = Movie.all

    if @keyword.present? || @genre.present? || @director.present? || @cast.present?
      @movies = Movie.all

      if @keyword.present?
        @movies = @movies.where('title LIKE ?', "%#{@keyword}%")
      end

      if @genre.present?
        @movies = @movies.where(genre: @genre)
      end

      if @director.present?
        @movies = @movies.where(director: @director)
      end

      if @cast.present?
        @movies = @movies.where(cast: @cast)
      end
    else
      @movies = []
    end
  end

  private

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
