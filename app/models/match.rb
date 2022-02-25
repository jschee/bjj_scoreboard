class Match < ApplicationRecord
  has_many :competitors, dependent: :destroy

  def competitor_one
    self.competitors.first
  end

  def competitor_two
    self.competitors.second
  end
end
