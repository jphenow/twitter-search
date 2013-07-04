class SearchesController < ApplicationController
  def create
    @result = "jon"
    respond_to do |f|
      f.js { render partial: "results" }
    end
  end
end
