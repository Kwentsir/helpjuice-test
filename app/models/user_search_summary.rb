class UserSearchSummary < ApplicationRecord
    has_many :search_sessions, class_name: "SearchSession", foreign_key: :session_id, primary_key: :session_id
    validates :session_id, uniqueness: true
    validates :ip, presence: true
    self.primary_key = :session_id
end
