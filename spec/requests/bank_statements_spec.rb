require 'rails_helper'

RSpec.describe "BankStatements", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/bank_statements/index"
      expect(response).to have_http_status(:success)
    end
  end

end
