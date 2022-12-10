require 'rails_helper'

RSpec.describe "Roots", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/root/input"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/root/show"
      expect(response).to have_http_status(:success)
    end
  end

end
