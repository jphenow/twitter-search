class SearchesController < ApplicationController
  def create
    @result = [params[:query]]
    render "results", layout: false
  end
end
