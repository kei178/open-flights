require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    subject { build(:review) }
    it { is_expected.to be_valid }

    it 'is invalid without an airline' do
      subject.airline = nil
      is_expected.to_not be_valid
    end
  end
end

