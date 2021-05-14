class Airline < ApplicationRecord
  has_many :reviews

  before_create :slugify

  validates :name, presence: true

  def avg_score
    return 0 if reviews.blank?

    reviews.average(:score).round(2).to_f
  end

  private

  def slugify
    self.slug = name.parameterize
  end
end
