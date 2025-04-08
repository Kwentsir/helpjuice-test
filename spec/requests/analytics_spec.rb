require 'rails_helper'

RSpec.describe "Analytics", type: :request do
  describe "GET /api/popular" do
    before do
      
      3.times { SearchQuery.create!(query: "ruby", ip: "127.0.0.1", session_id: "sess1") }
      2.times { SearchQuery.create!(query: "rails", ip: "127.0.0.2", session_id: "sess2") }
      SearchQuery.create!(query: "rspec", ip: "127.0.0.3", session_id: "sess3") 
    end

    it "returns http success" do
      get "/api/popular"
      expect(response).to have_http_status(:success)
    end

    it "returns the top search queries in descending order of count" do
      get "/api/popular"
      json = JSON.parse(response.body)

      expect(json).to eq({
        "ruby" => 3,
        "rails" => 2,
        "rspec" => 1
      })
    end
  end
end
