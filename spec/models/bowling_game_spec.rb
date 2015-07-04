require 'rails_helper'

RSpec.describe BowlingGame, type: :model do
  
 describe '#score' do
 
 	subject { BowlingGame.new }
 	
 	it { expect(subject).to respond_to(:score) }

 end

end
