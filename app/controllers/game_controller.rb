class GameController < ApplicationController

	def index
	end

	def show
		round_and_ball
		@pins_availables = 10
	end


	private

	def round_and_ball
		@round = params[:round_id]
		@ball = params[:ball_id]
	end
end