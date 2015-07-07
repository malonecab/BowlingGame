class GameController < ApplicationController
	include ActionView::Helpers::TextHelper

	before_filter :get_game, :except => [:create] 	
	before_filter :calculate_round_ball_and_pins


	def create
		@game = BowlingGame.create
		render :show
	end

	def update
		pins = params[:pins]
		@game.attempt(pins)
		if @game.save
			flash[:notice] = "#{pluralize(pins, 'pin')} knocked down."
			flash[:notice] += " #{@pins_availables} still up" unless new_round?			
			render :show			
		end
	end


	private
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