class BowlingGame
  include Mongoid::Document
  include Mongoid::Timestamps


  field :hits, type: Array, default: -> { Array.new() }

  def score
  	score = 0
  	index = 0
  	max_index = (hits.size == 12) ? 10 : hits.size-1

  	while index < max_index
   		if strike?(index)
  			score += strike_score(index)
  			index += 1
  		elsif spare?(index)
  			score += spare_score(index)
  			index += 2
  		else
  			score += hits[index] + hits[index+1] 
  			index += 2
  		end
  	end
  	score
  end

  def attempt(pins)
  	hits.push pins
  end

 private 


 	def strike?(index)
 		hits[index] == 10
 	end

 	def spare?(index)
 		hits[index] + hits[index+1] == 10
 	end

 	def strike_score(index)
		score = 10
		if (index+2) <= hits.size-1 
			score += hits[index+1] + hits[index+2]
		end		
 	end

 	def spare_score(index)
		score = 10 + hits[index+2]
	end
end
