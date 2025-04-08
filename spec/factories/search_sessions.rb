FactoryBot.define do
  factory :search_session do
    session_id { SecureRandom.uuid }
  end
end