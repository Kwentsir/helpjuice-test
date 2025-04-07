class AnalyticsController < ApplicationController
  def popular
    top_searches = SearchQuery
      .group(:query)
      .order('COUNT(*) DESC')
      .limit(10)
      .count

    render json: top_searches
  end
end
