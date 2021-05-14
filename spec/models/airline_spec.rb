require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe '#avg_score' do
    it 'returns avg score of reviews' do
      airline = create(:airline_with_reviews)
      avg = airline.reviews.average(:score).round(2).to_f
      expect(airline.avg_score).to eq(avg)
    end

    it 'returns 0 when no reviews' do
      airline = build(:airline)
      expect(airline.avg_score).to be_zero
    end
  end

  describe 'callback' do
    let(:airline) { build(:airline) }

    it 'sets slug using name before create' do
      expect(airline.slug).to be_blank
      airline.save!
      airline.reload
      expect(airline.slug).to eq(airline.name.parameterize)
    end
  end

  describe 'validations' do
    subject { build(:airline) }

    it { is_expected.to be_valid }
    it 'is invalid without name' do
      subject.name = nil
      is_expected.to_not be_valid
    end
  end
end
