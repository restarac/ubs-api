require 'rails_helper'

RSpec.describe 'ubs API', type: :request do
  let!(:ubs) { create_list(:ubs, 15) }

  describe 'GET /ubs' do
    before { get '/ubs' }

    it 'returns the total entries' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json["total_entries"]).to eq(15)
    end

    it 'returns the defaults per page value' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json["per_page"]).to eq(10)
    end

    it 'returns the exactly 10 ubs' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json["entries"].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end