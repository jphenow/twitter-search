class SearchesController < ApplicationController
  def create
    @results = SearchEngine.new(query_params[:query], location_params).search
    render "results", layout: false
  end

  private

  def results
    if @results
      @results_decorators ||= StatusDecorator.decorate_collection @results
    else
      []
    end
  end
  helper_method :results

  def query_params
    params.permit :query
  end

  def location_params
    params.permit :geocode, :latitude, :longitude, :radius
  end
end
