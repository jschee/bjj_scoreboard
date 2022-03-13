class Match < ApplicationRecord
  attr_accessor :competitor_one, :competitor_two

  has_many :competitors, dependent: :destroy

  after_create_commit :create_competitors

  validates :competitor_one, presence: true
  validates :competitor_two, presence: true

  after_update_commit :update_timer

  def competitor_one
    competitors.first
  end

  def competitor_two
    competitors.second
  end

  def update_timer
    return unless start_time_previously_changed?
    broadcast_update_to(self,
                        target: 'timer',
                        partial: 'matches/timer',
                        locals: { start_time: start_time })
  end

  private

    def create_competitors
      return unless competitor_one.present? && competitor_two.present?
      Competitor.create!(name: competitor_one, match: self)
      Competitor.create!(name: competitor_two, match: self)
    end
end