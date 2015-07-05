class BowlingGame
  include Mongoid::Document
  include Mongoid::Timestamps


  field :hits, type: Array, default: -> { Array.new() }

  def score
  	score = 0
  	index = 0
  	max_index = (hits.size == 12) ? 9 : hits.size-1

  	while index <= max_index
   		if strike?(index)
  			score += strike_score(index)	
  		elsif spare?(hits[index])

  		else
  			score += hits[index]
  		end
  		index += 1
  	end
  	return score
  end

  def attempt(pins)
  	hits.push pins
  end

 private 


 	def strike?(index)
 		hits[index] == 10
 	end

 	def spare?(index)
 	end

 	def strike_score(index)
		score = 10
		if (index+2) <= hits.size-1 
			score += hits[index+1] + hits[index+2]
		end
		score
 	end

end
