class BowlingGame
  include Mongoid::Document
  include Mongoid::Timestamps

  field :hits, type: Array, default: -> { Array.new() }

  def score
  	hits.inject(0) { |total, hit| total + hit }
  end

  def attempt(pins)
  	hits.push pins
  end

end
