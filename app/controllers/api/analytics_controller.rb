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
    def user_analytics
        session_id = session.id.to_s
        user_summary = UserSearchSummary.find_by(session_id: session_id)

        if user_summary
          render json: { analytics: user_summary.search_counts }
        else
          render json: { analytics: {} }
        end
    end
  end
end