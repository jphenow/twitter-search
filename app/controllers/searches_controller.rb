class SearchesController < ApplicationController
  def create
    @results = SearchEngine.new(params[:query]).search
    render "results", layout: false
  end

  private

  def results
    if @results
      @results_decorators ||= TweetDecorator.decorate_collection @results
    else
      []
    end
  end
  helper_method :results
end
