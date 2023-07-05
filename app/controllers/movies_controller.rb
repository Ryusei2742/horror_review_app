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
    @query = params[:query]
    @movies = Movie.where('title LIKE ?', "%#{@query}%")   #title カラムを部分一致で検索している
  end

  private

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
