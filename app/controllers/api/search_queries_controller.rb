# module Api
#   class SearchQueriesController < ApplicationController

#     @@incomplete_searches = {}

#     @@search_timers = {}

#     DEBOUNCE_INTERVAL = 1.0

#     def create
#       session[:initialized] ||= true
#       session_id = session.id.to_s
#       query = params[:query].to_s.strip
#       ip = request.remote_ip

#       return head :bad_request if session_id.blank? || query.blank?

#       session = SearchSession.find_or_initialize_by(ip: ip, session_id: session_id).tap do |session|
#         session.last_query = query
#         session.updated_at = Time.current
#         session.save!
#      end

#     if @@search_timers[session_id]
#         @@search_timers[session_id].shutdown
#         @@incomplete_searches[session_id] = query
#       else
#         @@incomplete_searches[session_id] = query
#         @@search_timers[session_id] = Concurrent::TimerTask.new(execution_interval: DEBOUNCE_INTERVAL, timeout_interval: 2) do
#           Rails.logger.debug("Timer triggered for #{session_id}, performing FinalizeSearchSessionJob")
#           completed_query = @@incomplete_searches.delete(session_id)
#           @@search_timers.delete(session_id)
#           if completed_query.present?
#             FinalizeSearchSessionJob.perform_async(ip, session_id, completed_query)
#           end
#         end
#         @@search_timers[session_id].execute
#       end

#       @@search_timers[session_id] = timer_task
#       timer_task.execute

#       head :ok
#     end
#   end
# end

module Api
  class SearchQueriesController < ApplicationController
    def create
      query = params[:query] || params.dig(:search_query, :query)
      return head :bad_request if query.blank?

      ip = request.remote_ip
      session_id = session.id.to_s

      session = SearchSession.find_or_create_by(ip: ip, session_id: session_id)
      session.update!(last_query: query)

      # Schedule background job to finalize session
      FinalizeSearchSessionJob.perform_in(10.seconds, session.id)

      head :ok
    end
  end
end
