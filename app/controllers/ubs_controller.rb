class UbsController < ApplicationController
  DEFAULT_STARTING_PAGE = 1
  DEFAULT_PER_PAGE = 10
  
  def index
    page = params["page"] || DEFAULT_STARTING_PAGE
    per_page = params["per_page"] || DEFAULT_PER_PAGE

    ubs_list = Ubs.paginate_by_sql("SELECT * FROM ubs", page: page, per_page: per_page)

    presenter = UbsListPresenter.with(
      entries: ubs_list,
      per_page: ubs_list.per_page,
      total_entries: ubs_list.total_entries,
      current_page: ubs_list.current_page.to_i
    )
    representer = UbsListRepresenter.new(presenter)

    render json: representer
  end
end
