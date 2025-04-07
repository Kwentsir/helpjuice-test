require 'rails_helper'

RSpec.describe "Analytics", type: :request do
  describe "GET /popular" do
    it "returns http success" do
      get "/analytics/popular"
      expect(response).to have_http_status(:success)
    end
  end

end
