class CompetitorsController < ApplicationController
  before_action :set_match
  before_action :set_label, only: [:new, :create]

  def new
    @competitor = Competitor.new
  end

  def create
    @competitor = Competitor.new(competitor_params.merge(match: @match))

    respond_to do |format|
      if @competitor.save
        if @match.competitors.size >= 2
          format.html { redirect_to match_path(@match) }
        else
          format.html { redirect_to new_match_competitor_path }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @competitor = Competitor.find(params[:id])
  end

  def update
    @competitor = Competitor.find(params[:id])
    @competitor.update(competitor_params)
  end

  private
    def competitor_params
      params.require(:competitor).permit(:name, :match_id)
    end

    def set_match
      @match = Match.find(params[:match_id])
    end

    def set_label
      if @match.competitors.size == 0
        @competitor_label = "Enter First Competitor's name"
      else
        @competitor_label = "Enter Second Competitor's name"
      end
    end
end