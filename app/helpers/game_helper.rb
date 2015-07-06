module GameHelper

	def game_route(round=nil, ball=nil)
		if round.nil? && ball.nil?
			game_path(1,1)
		else
			game_path(round, ball)
		end
	end
end