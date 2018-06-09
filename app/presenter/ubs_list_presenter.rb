class UbsListPresenter
  attr_reader :entries, :per_page, :current_page, :total_entries

  def initialize(list:, total_without_pages:, per_page:, current_page:)
    @entries = list
    @total_entries =  total_without_pages
    @per_page = per_page
    @current_page = current_page
  end
end