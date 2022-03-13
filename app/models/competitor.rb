class Competitor < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :match, optional: true
  has_one :score, dependent: :destroy

  after_create :create_score
  after_update_commit :broadcast_now

  validates :name, presence: true

  private

  def broadcast_now
    broadcast_update_to(match,
                        target: 'competitor_one_private_details',
                        partial: 'matches/competitor_one/competitor_one_private_details',
                        locals: { match: match })
    broadcast_update_to(match,
                        target: 'competitor_one_public_details',
                        partial: 'matches/competitor_one/competitor_one_public_details',
                        locals: { match: match })
    broadcast_update_to(match,
                        target: 'competitor_two_private_details',
                        partial: 'matches/competitor_two/competitor_two_private_details',
                        locals: { match: match })
    broadcast_update_to(match,
                        target: 'competitor_two_public_details',
                        partial: 'matches/competitor_two/competitor_two_public_details',
                        locals: { match: match })
  end

  def create_score
    Score.create!(competitor: self)
  end
end
