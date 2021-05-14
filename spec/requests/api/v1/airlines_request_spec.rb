require 'rails_helper'

RSpec.describe 'API V1 Airline requests' do
  let(:options) { { include: %i[reviews] } }

  describe 'GET /api/v1/airlines' do
    it 'returns a list of airlines' do
      2.times { create(:airline_with_reviews) }
      airlines = Airline.all
      expected = AirlineSerializer.new(airlines, options).serialized_json

      get '/api/v1/airlines',
          headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected)
    end
  end

  describe 'POST /api/v1/airlines' do
    it 'creates an airline' do
      params = {
        airline: {
          name: 'Test Airline'
        }
      }.to_json

      post '/api/v1/airlines',
           params: params,
           headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response.status).to eq(200)
      expect(Airline.all.count).to eq(1)
    end

    it 'returns an error if params are invalid' do
      params = {
        airline: {
          naem: 'Test Airline'
        }
      }.to_json

      post '/api/v1/airlines',
           params: params,
           headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response.status).to eq(422)
      expect(Airline.all).to be_blank
    end
  end

  describe 'GET /api/v1/airlines/:slug' do
    it 'returns an airline' do
      airline = create(:airline_with_reviews)
      expected = AirlineSerializer.new(airline, options).serialized_json
      get "/api/v1/airlines/#{airline.slug}",
          headers: { 'CONTENT_TYPE': 'application/json' }

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected)
    end

    it 'returns a 404 error when not found' do
      expect do
        get '/api/v1/airlines/test-airline',
            headers: { 'CONTENT_TYPE': 'application/json' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT /api/v1/airlines/:slug' do
    it 'updates an airline' do
      airline = create(:airline)
      params = {
        airline: {
          name: 'Updated name'
        }
      }.to_json
      put "/api/v1/airlines/#{airline.slug}",
          params: params,
          headers: { 'CONTENT_TYPE': 'application/json' }

      airline.reload
      expect(response.status).to eq(200)
      expect(airline.name).to eq('Updated name')
    end

    it 'returns a 404 error when not found' do
      expect do
        put '/api/v1/airlines/test-airline',
            headers: { 'CONTENT_TYPE': 'application/json' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns errors when params are invalid' do
      airline = create(:airline)
      params = {
        airline: {
          name: ''
        }
      }.to_json
      put "/api/v1/airlines/#{airline.slug}",
          params: params,
          headers: { 'CONTENT_TYPE': 'application/json' }

      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE /api/v1/airlines/:slug' do
    it 'deletes an airline' do
      airline = create(:airline)
      id = airline.id
      delete "/api/v1/airlines/#{airline.slug}",
             headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response.status).to eq(204)
      expect { Airline.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
