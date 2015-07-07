class GameController < ApplicationController
	include ActionView::Helpers::TextHelper

	before_filter :get_game, :except => [:create] 	
	before_filter :calculate_round_ball_and_pins


	def create
		@game = BowlingGame.create
		render :show
	end

	def update
		pins = params[:pins].to_i
		@game.attempt(pins)
		if @game.save
			if game_finished?
				redirect_to finished_game_url(@game.id.to_s)
			else
				flash[:notice] = get_notice(pins)
				render :show
			end
		end
	end

	def finished

	end

	private
	def game_finished?
		@round.to_i > 10
	end

	def get_notice(pins_down)
		if strike? (pins_down)
			"STRIKE!"
		elsif spare?(pins_down)
			"SPARE!"
		else
			notice = "#{pluralize(pins_down, 'pin')} knocked down."
			notice += " #{@pins_availables} still up" unless new_round?			
		end
	end

	def strike?(pins_down)
		pins_down == 10
	end

	def spare?(pins_down)
		last_hit = @game.hits[-2].to_i
		(pins_down + last_hit) == 10
	end

	def new_round?
		@ball.to_i.odd?
	end

	def calculate_round_ball_and_pins
		@round = params[:round_id] || 1
		@ball = params[:ball_id] || 1
		@pins_availables = 10

		if params[:pins].present? && @ball.to_i.even?
			@pins_availables -= params[:pins].to_i
		end
	end

	def get_game
		@game = BowlingGame.find(params[:id]) rescue BowlingGame.new
	end
end