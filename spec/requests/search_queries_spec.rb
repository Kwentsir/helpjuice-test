require 'rails_helper'

RSpec.describe "SearchQueries", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/search_queries/create"
      expect(response).to have_http_status(:success)
    end
  end

end
