class Score < ApplicationRecord
  belongs_to :competitor
  has_one :match, through: :competitor
  after_update_commit :broadcast_now

  private
    def broadcast_now
      broadcast_update_to(match,
                          target: 'competitor_one_private',
                          partial: 'matches/competitor_one/competitor_one_private',
                          locals: { match: match })
      broadcast_update_to(match,
                          target: 'competitor_two_private',
                          partial: 'matches/competitor_two/competitor_two_private',
                          locals: { match: match })
      broadcast_update_to(match,
                          target: 'competitor_one_public',
                          partial: 'matches/competitor_one/competitor_one_public',
                          locals: { match: match })
      broadcast_update_to(match,
                          target: 'competitor_two_public',
                          partial: 'matches/competitor_two/competitor_two_public',
                          locals: { match: match })
    end
end
