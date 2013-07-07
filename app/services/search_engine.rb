class SearchEngine
  def initialize(query, location_params = {})
    self.query = query
    self.location_params = location_params || {}
  end

  def search
    @search_results ||= engine.call(*query_params)
  end
  alias statuses search
  alias tweets search
  alias results search

  private

  attr_accessor :query
  attr_accessor :location_params

  def send_location_params?
    coordinates_present? && geocode_truthy?
  end

  def coordinates
    [latitude, longitude]
  end

  def coordinates_present?
    coordinates.all? &:present?
  end

  def geocode_truthy?
    geocode == "1" || geocode == true || geocode == "true"
  end

  def geocode
    location_params[:geocode]
  end

  def latitude
    location_params[:latitude]
  end

  def longitude
    location_params[:longitude]
  end

  def radius
    "#{raw_radius}mi"
  end

  def raw_radius
    raw = location_params[:radius].to_i
    raw > 0 ? raw : 10
  end

  def geocode_param
    (coordinates + [radius]).join(",") if send_location_params?
  end

  def options
    options = {}
    options[:geocode] = geocode_param if geocode_param
    options
  end

  def query_params
    [query, options]
  end

  def engine
    ->(*args) { Twitter.search(*args).statuses }
  end
end
