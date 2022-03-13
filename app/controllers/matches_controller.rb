class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :public]
  before_action :update_timer, only: [:timer]


  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to match_path(@match)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def public; end

  def timer; end

  private

    def match_params
      params.require(:match).permit(:competitor_one, :competitor_two)
    end

    def set_match
     @match = Match.find(params[:id])
    end

    def update_timer
      set_match
      if params[:result].present?
        if params[:result] == "increment"
          @match.start_time += params[:time]
        else
          @match.start_time -= params[:time]
        end
        @match.save
      else # stop button
        @match.start_time = params[:time]
        @match.save
      end
    end
end