class GameController < ApplicationController
	before_filter :round_and_ball

	def new
		redirect_to show_game_url(@round, @ball)
	end

	def show
		round_and_ball
		@pins_availables = 10
	end


	private

	def round_and_ball
		@round = params[:round_id] || 1
		@ball = params[:ball_id] || 1
	end
end