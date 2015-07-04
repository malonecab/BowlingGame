class BowlingGame
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :frames
  def score
  	0
  end

end
