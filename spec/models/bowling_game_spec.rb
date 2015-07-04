require 'rails_helper'

RSpec.describe BowlingGame, type: :model do
  

 
 	subject { BowlingGame.new }
 	
 	describe "public class methods" do
  	context "responds to its methods" do
 			it { expect(subject).to respond_to(:score) }
 		end

 		context "executes methods correctly" do
 			it { expect(subject.score).to be 0 }
 		end

 	end

end


