class GameController < ApplicationController
	before_filter :round_ball_and_pins
	before_filter :get_game, :except => [:new] 

	def new
		@game = BowlingGame.new
		render :show
	end

	def show
	end


	private

	def round_ball_and_pins
		@round = params[:round_id] || 1
		@ball = params[:ball_id] || 1
		@pins_availables = 10 
	end

	def get_game
		#@game = BowlingGame.
	end
end