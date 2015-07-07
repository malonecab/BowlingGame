class GameController < ApplicationController
	include ActionView::Helpers::TextHelper

	before_filter :set_params
	before_filter :get_game, :calculate_round_ball_and_pins, :except => [:create] 	
	
	def create
		@game = BowlingGame.create
		render :show
	end

	def update
		@game.attempt(@pins_down)
		if @game.save
			if game_finished?
				redirect_to finished_game_url(@game.id.to_s)
			else
				flash[:notice] = get_notice(@pins_down)
				if strike? @pins_down
					redirect_to show_game_url(@game.id.to_s, @round, @ball)
				else
					render :show
				end
			end
		end
	end

	def finished
	end

	private
	def game_finished?
		(@round == 11 && @ball == 1 && @pins_down < 10) ||
		(@round == 11 && @ball == 2)
	end

	def get_notice(pins_down)
		if strike? pins_down
			"STRIKE!"
		elsif spare? pins_down
			"SPARE!"
		else
			notice = "#{pluralize(pins_down, 'pin')} knocked down."
			notice += " #{@pins_availables} still up" unless new_round?			
		end
	end

	def spare?(pins_down)
		last_hit = @game.hits[-2].to_i
		strike?(pins_down + last_hit)
	end

	def new_round?
		@ball.to_i.odd?
	end

	def calculate_round_ball_and_pins
		if strike?(@pins_down) || @ball == 2
			@round = @round + 1
			@ball = 1
		elsif @pins_down >= 0
			@ball =  @ball + 1
			@pins_availables = @pins_availables - @pins_down
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