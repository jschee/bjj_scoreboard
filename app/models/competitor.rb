class Competitor < ApplicationRecord
  belongs_to :match
  has_one :score, dependent: :destroy

  after_create :create_score

  private

  def create_score
    Score.create!(competitor: self)
  end
end
