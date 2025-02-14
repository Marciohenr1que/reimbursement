# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  included do
    before_action :set_pagination_params
  end

  private

  def set_pagination_params
    @page = params[:page] || 1
    @per_page = params[:per_page] || Kaminari.config.default_per_page
  end

  def paginate(collection)
    collection.page(@page).per(@per_page)
  end
end
