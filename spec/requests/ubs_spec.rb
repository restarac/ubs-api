require 'rails_helper'

RSpec.describe 'ubs API', type: :request do
  let!(:ubs) { create_list(:ubs, 10) }

  describe 'GET /ubs' do
    before { get '/ubs' }

    it 'returns a ubs list' do
      expect(json).not_to be_empty
      expect(json.total_entries).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end