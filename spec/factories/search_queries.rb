FactoryBot.define do
  factory :search_query do
    query { "example" }
    ip { "127.0.0.1" }
    session_id { SecureRandom.uuid }
    finalized_at { Time.current }
  end
end