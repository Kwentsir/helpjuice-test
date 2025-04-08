require 'rails_helper'

RSpec.describe SearchQuery, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:query) }
    it { should validate_presence_of(:ip) }
    it { should validate_presence_of(:session_id) }
  end

  describe '.recent' do
    it 'returns queries ordered by finalized_at descending' do
      older = create(:search_query, finalized_at: 1.day.ago)
      newer = create(:search_query, finalized_at: 1.hour.ago)

      expect(SearchQuery.recent).to eq([newer, older])
    end
  end
end
