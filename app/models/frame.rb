class Frame
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_TRIES = 2
  embedded_in :bowling_game
 	
 	
	field :hits, type: Array, default: -> { Array.new() }

	validate :validate_hits
	
	def validate_hits
    errors.add(:hits, "to many tries") if hits.size > MAX_TRIES
  end

	def hit(pins)
		hits.push(pins)
	end
end
