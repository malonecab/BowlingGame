class GameController < ApplicationController

	def index
	end

	def show
		round_and_ball
	end


	private

	def round_and_ball
		@round = params[:round_id]
		@ball = params[:ball_id]
	end
end