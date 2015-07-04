class Frame
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_TRIES = 2
  embedded_in :bowling_game
 	
 	
	field :hits, type: Array, default: -> { Array.new() }

	validate :validates_number_of_hits
	
	def validates_number_of_hits
		if hits.size > MAX_TRIES
    	errors.add(:hits, "to many attempts, valid only #{MAX_TRIES}") 
    end
  end

	def hit(pins)
		hits.push(pins)
	end
end
