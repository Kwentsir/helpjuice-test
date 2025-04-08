module Api
  class SearchQueriesController < ApplicationController
    def create
      session_id = request.headers['X-Session-ID']
      query = params[:query].to_s.strip
      ip = request.remote_ip

      return head :bad_request if session_id.blank? || query.blank?

      session = SearchSession.find_or_initialize_by(ip: ip, session_id: session_id)
      session.last_query = query
      session.updated_at = Time.current
      session.save!

      head :ok
    end
  end
end