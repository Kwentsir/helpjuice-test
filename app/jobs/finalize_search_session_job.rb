
class FinalizeSearchSessionJob
  include Sidekiq::Worker

  def perform
    
    SearchSession.where('updated_at < ?', 10.seconds.ago).find_each do |session|
      
      SearchQuery.find_or_create_by!(
        ip: session.ip,
        session_id: session.session_id,
        query: session.query
      ) do |query|
        query.finalized_at = Time.now
      end

      
      session.destroy
    end
  end
end
