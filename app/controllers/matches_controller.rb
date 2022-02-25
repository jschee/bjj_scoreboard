class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new
    if @match.save
      redirect_to new_match_competitor_path(@match)
    end
  end

  def show
    @match = Match.find(params[:id])
  end
end