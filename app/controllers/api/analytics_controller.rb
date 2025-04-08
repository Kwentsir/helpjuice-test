module Api  
  class AnalyticsController < ApplicationController
    def popular
      top_searches = Rails.cache.fetch('top_searches', expires_in: 10.minutes) do
        SearchQuery
          .group(:query)
          .count
          .sort_by { |_, count| -count }
          .first(10)
          .to_h
      end

      render json: top_searches
    end
  end
end