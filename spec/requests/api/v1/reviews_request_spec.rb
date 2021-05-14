require 'rails_helper'

RSpec.describe 'API V1 Review requests' do
  let(:review) { create(:review) }
  let(:airline) { create(:airline) }

  describe 'POST /api/v1/reviews' do
    it 'creates a review' do
      params = {
        review: {
          title: 'Sample review',
          description: 'This airline was awesome!'
        },
        airline_id: airline.id
      }.to_json

      post '/api/v1/reviews',
           params: params,
           headers: { 'CONTENT_TYPE': 'application/json' }

      expect(response.status).to eq(200)
      expect(airline.reviews.count).to eq(1)
    end

    it 'droes not create a review when params are invalid' do
      params = {
        review: {
          title: 'Sample review',
          description: 'This airline was awesome!'
        }
      }.to_json

      expect do
        post '/api/v1/reviews',
             params: params,
             headers: { 'CONTENT_TYPE': 'application/json' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /api/v1/review/:id' do
    it 'deletes a review' do
      id = review.id
      delete "/api/v1/reviews/#{id}",
             headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response.status).to eq(204)
      expect { Review.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
