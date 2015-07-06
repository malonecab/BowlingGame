module GameHelper

	def game_route(round=nil, ball=nil)
		if round.nil? && ball.nil?
			game_path(1,1)
		else
			game_path(round, ball)
		end
	end

	def next_path_after_attempt(game_id, round, ball, available_pins, pins)
		if (pins == 10 || (pins <= available_pins && ball == 2))
			update_game_path(game_id, round+1, 1)
		else	
			update_game_path(game_id, round, ball+1)
		end
	end

end