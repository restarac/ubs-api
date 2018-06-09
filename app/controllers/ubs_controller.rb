class UbsController < ApplicationController
  def index
    page = params["page"]
    per_page = params["per_page"]
    query = params["query"]

    if query
      latitude, longitude = query.split(",")

      UbsPaginatedService.new.by_geo_proximity(
        latitude: latitude,
        longitude: longitude
      )
    else
      presenter = UbsPaginatedService.new.all()
    end
    
    representer = UbsListRepresenter.new(presenter)

    render json: representer
  end
end
