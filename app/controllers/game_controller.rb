class GameController < ApplicationController
	before_filter :calculate_round_ball_and_pins
	before_filter :get_game, :except => [:new] 

	def create
		@game = BowlingGame.create
		render :show
	end

	def update
		@game.attempt(params[:pins])
		@game.save
	end


	private

	def calculate_round_ball_and_pins
		@round = params[:round_id] || 1
		@ball = params[:ball_id] || 1
		@pins_availables = 10

		return if @ball == 1
		
		if @ball.to_i.even?
			@pins_availables -= params[:pins].to_i
		else
		 	@pins_availables -= @game.hits.last
		 end
	end

	def get_game
		@game = BowlingGame.find(params[:id]) rescue BowlingGame.new
	end
end