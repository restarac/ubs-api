class UbsPaginatedService
  DEFAULT_STARTING_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def initialize(current_page: DEFAULT_STARTING_PAGE, per_page: DEFAULT_PER_PAGE)
    @current_page = current_page || DEFAULT_STARTING_PAGE
    @per_page = per_page || DEFAULT_PER_PAGE
  end

  def find_by_query_or_default(query: query)
    if query.blank?
      # default search when there is no query
      presenter = UbsPaginatedService.new.all()
    else
      latitude, longitude = query.split(",")

      UbsPaginatedService.new.by_geo_proximity(
        latitude: latitude,
        longitude: longitude
      )
    end
  end

  def all
    ubs_list = Ubs.paginate_by_sql(
      "SELECT * FROM ubs",
      page: @current_page, 
      per_page: @per_page
    )

    represent_list_with(ubs_list)
  end

  def by_geo_proximity(latitude:, longitude:)
    geo_proximity = GeoProximityMYSQL.new(latitude: latitude, longitude: longitude)
    
    ubs_list = Ubs.paginate_by_sql(
      geo_proximity.to_sql, 
      page: @current_page, 
      per_page: @per_page
    )

    represent_list_with(ubs_list)
  end

  private

  def represent_list_with(ubs_list)
    UbsListPresenter.with(
      entries: ubs_list,
      per_page: ubs_list.per_page,
      total_entries: ubs_list.total_entries,
      current_page: ubs_list.current_page.to_i
    )
  end

  class GeoProximityMYSQL
    PROXIMITY_DISTANCE_IN_KILOMETERS = 10

    attr_reader :latitude, :longitude

    def initialize(latitude:, longitude:)
      @latitude = latitude.to_f
      @longitude = latitude.to_f
    end

    def to_sql
      # 1 degree of latitude ~= 111.04 Kms
      # 1 degree of longitude ~= cos(latitude) * 111.04 Kms
      dist = PROXIMITY_DISTANCE_IN_KILOMETERS

      # with that i can calculate the boundary, this will speedup the query
      long1 = (longitude – dist) / (cosine(latitude) * 111.04).abs
      long2 = longitude + dist / (cosine(latitude) * 111.04).abs

      lat1 = latitude – dist / (111.04)
      lat2 = latitude + dist / (111.04)
      
      <<-SQL
        SELECT id, name,
        6371 * 2 * ASIN(SQRT(POWER(SIN(RADIANS(#{latitude} - ABS(ubs.latitude))), 2) + COS(RADIANS(#{latitude})) * COS(RADIANS(ABS(ubs.latitude))) * POWER(SIN(RADIANS(#{longitude} - ubs.longitude)), 2))) AS distance
        FROM ubs
        WHERE ubs.latitude BETWEEN #{lat1} AND #{lat2} AND ubs.longitude BETWEEN #{long1} AND #{long2}
        HAVING distance < #{PROXIMITY_DISTANCE_IN_KILOMETERS}
        ORDER BY distance;
      SQL
    end

    private

    def to_radians(degrees)
      degrees * Math::PI / 180 
    end

    def cosine(degrees)
      Math.cos to_radians(degrees)
    end
  end
end
