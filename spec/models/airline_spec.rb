require 'rails_helper'

RSpec.describe Airline, type: :model do
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
