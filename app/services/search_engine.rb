class SearchEngine
  def initialize(query)
    self.query = query
  end

  def search
    @search_results ||= engine.call(*query_params)
  end
  alias statuses search
  alias tweets search
  alias results search

  private

  attr_accessor :query

  def query_params
    [query]
  end

  def engine
    ->(*args) { Twitter.search(*args).statuses }
  end
end
