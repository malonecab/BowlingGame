class GameController < ApplicationController
	include ActionView::Helpers::TextHelper

	before_filter :calculate_round_ball_and_pins
	before_filter :get_game, :except => [:new] 

	def create
		@game = BowlingGame.create
		render :show
	end

	def update
		pins = params[:pins]
		@game.attempt(pins)
		if @game.save
			flash[:notice] = "#{pluralize(pins, 'pin')} knocked down.\
						#{pluralize(@pins_availables, 'pin')} still up"
		end
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