class GameController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_filter :set_params
  before_filter :get_game, :except => [:create]
  before_filter :calculate_round_ball_and_pins, :only => [:update]  
  
  def create
    @ball = 1
    @round = 10
    @game = BowlingGame.create
    render :show
  end

  def update
    @game.attempt(@pins_down)
    @game.save
    if game_finished?
      redirect_to finished_game_url(@game.id.to_s)
    else
      flash[:notice] = get_notice(@pins_down)
      redirect_to show_game_url(@game.id.to_s, @round, @ball)       
    end
  end

  def show
    if last_hit = @game.hits.last.to_i
      @pins_availables -= last_hit if last_hit < 10
    end
  end

  def finished
  end

  private
  def game_finished?
    (@round == 11 && @ball == 1 && @pins_down < 10) ||
    (@round == 11 && @ball == 3)
  end

  def get_notice(pins_down)
    if strike? pins_down
      "STRIKE!"
    elsif spare? pins_down
      "SPARE!"
    else
      "#{pluralize(pins_down, 'pin')} knocked down."    
    end
  end

  def spare?(pins_down)
    last_hit = @game.hits[-2].to_i
    strike?(pins_down + last_hit)
  end

  def calculate_round_ball_and_pins
    if extra_round? && @pins_down >= 0
      @ball = @ball + 1
    elsif strike?(@pins_down) || @ball == 2
      @round = @round + 1
      @ball = 1
    elsif @pins_down >= 0
      @ball = @ball + 1
    end
  end

  def extra_round?
    @round == 11
  end

  def strike?(pins_down)
    pins_down == 10
  end

  def get_game
    @game = BowlingGame.find(params[:id]) rescue BowlingGame.new
  end

  def set_params
    @round = params[:round_id].present? ? params[:round_id].to_i : 1
    @ball =  params[:ball_id].present? ? params[:ball_id].to_i : 1
    @pins_down = params[:pins].present? ? params[:pins].to_i : -1
    @pins_availables = 10
  end

end