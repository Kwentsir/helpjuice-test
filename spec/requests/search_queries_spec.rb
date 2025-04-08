require 'rails_helper'

RSpec.describe "SearchQueries", type: :request do
  describe "POST /api/search_queries" do
    let(:valid_params) { { query: "sample query" } }
    let(:headers) { { 'X-Session-ID' => 'some-session-id' } }

  it "returns http success" do
    post "/api/search_queries", params: valid_params, headers: headers
    expect(response).to have_http_status(:success)
  end

  it "creates a search session" do
    expect {
      post "/api/search_queries", params: valid_params, headers: headers
    }.to change(SearchSession, :count).by(1)
  end
  end
end
