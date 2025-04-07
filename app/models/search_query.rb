class SearchQuery < ApplicationRecord
    validates :query, presence: true
    validates :ip, presence: true
    validates :session_id, presence: true
    scope :recent, -> { order(finalized_at: :desc) }
end
