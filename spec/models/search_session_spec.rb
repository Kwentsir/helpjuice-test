require 'rails_helper'

RSpec.describe SearchSession, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:session_id) }
  end
end
