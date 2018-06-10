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

  context 'with a specific point in 10 meter of radius' do
    describe 'GET /ubs?query=-23.60,-46.69' do
      let!(:ubs_nexting) { create :ubs, latitude: -23.604936, longitude: -46.692999  }
      
      before { get '/ubs?query=-23.604936,-46.692999' }
      
      it 'returns the total entries' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json["total_entries"]).to eq(1)
      end
      
      it 'returns the exactly 1 ubs' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json["entries"].size).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
