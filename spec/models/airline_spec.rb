require 'rails_helper'

RSpec.describe Airline, type: :model do
  context 'callback' do
    let(:airline) { build(:airline) }

    it 'sets slug using name before create' do
      expect(airline.slug).to be_blank
      airline.save!
      airline.reload
      expect(airline.slug).to eq(airline.name.parameterize)
    end
  end
end
