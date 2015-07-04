class Frame
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :bowling_game
 

end
