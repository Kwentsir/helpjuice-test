class SearchSession < ApplicationRecord
  validates :ip, presence: true
  validates :session_id, presence: true
  validates :last_query, presence: true
end
