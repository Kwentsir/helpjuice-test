class FinalizeSearchSessionJob
  include Sidekiq::Worker

  def perform(session_id)
    session = SearchSession.find(session_id)
    
    return if session.nil?
    return if session.updated_at > 10.seconds.ago

    finalize_session(session)
  end

  private

  def finalize_session(session)
    search_term = session.last_query
    ip_address = session.ip
    session_id = session.session_id

    return if search_term.blank? || search_term.length < 2

    SearchQuery.find_or_create_by!(
      ip: ip_address,
      session_id: session_id,
      query: search_term
    ) do |query|
      query.finalized_at = Time.current
    end

    summary = UserSearchSummary.find_or_initialize_by(session_id: session_id)
    summary.ip = ip_address
    summary.search_counts ||= {}
    summary.search_counts[search_term] ||= 0
    summary.search_counts[search_term] += 1
    summary.save!
    Rails.logger.debug("UPDATED ANALYTICS for #{ip_address}: #{summary.search_counts}")

    session.destroy
  end
end
