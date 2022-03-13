class ScoresController < ApplicationController
  before_action :set_competitor
  before_action :set_score
  before_action :set_match

  def update
    type = params[:type].to_unsafe_h
    @column = type.keys.first.to_sym
    @value = type.values.first.to_i
    @current_total_point = @score.send(@column)
    calculate_score
  end

  private
    def score_params
      params.require(:score).permit(:point, :advantage, :penalty, :type)
    end

    def set_competitor
      @competitor = Competitor.find(params[:competitor_id])
    end

    def set_score
      @score = Score.find(params[:id])
    end

    def set_match
      @match = Match.find(params[:match_id])
    end

    def calculate_score
      if params[:increment] == 'true'
        @current_total_point += @value
        @score.update_attribute(@column, @current_total_point)
      else
        @current_total_point -= @value
        @score.update_attribute(@column, @current_total_point)
      end
    end
end