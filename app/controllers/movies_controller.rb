class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def new
  end
end
