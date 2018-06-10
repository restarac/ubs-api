class UbsController < ApplicationController
  def index
    page = params["page"]
    per_page = params["per_page"]
    query = params["query"]
    service = UbsPaginatedService.new(current_page: page, per_page: per_page)

    presenter = service.find_by_query_or_default(query)
    
    representer = UbsListRepresenter.new(presenter)

    render json: representer
  end
end
