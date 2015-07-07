module GameHelper

	def next_path_after_attempt(game_id, round, ball, available_pins, pins)
		if pins == 10 || (pins <= available_pins && ball == 2)
			round = round + 1
			ball = 1
		else
			ball = ((ball + 1).odd?) ? 1 : 2
		end
		update_game_path(game_id, round, ball, pins)
	end
end
