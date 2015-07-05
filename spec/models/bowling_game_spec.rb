require 'rails_helper'

RSpec.describe BowlingGame, type: :model do
   
 	subject { BowlingGame.new }
 	
  
 	describe "public class methods" do
  	context "responds to its methods" do
 			it { expect(subject).to respond_to(:score) }
      it { expect(subject).to respond_to(:attempt) }
 		end

 		describe "#score" do
 			it { expect(subject.score).to be 0 }

      it '0 after 20 attempts with 0 pins down' do
        20.times { subject.attempt(0) }
        expect(subject.score).to be 0
      end
      it '20 after 20 attempts with 1 pins down' do
        20.times { subject.attempt(1) }
        expect(subject.score).to be 20
      end
      
      it '30 after 1 strike and 18 attempts with 1 pins down' do
        subject.attempt(10)
        18.times { subject.attempt(1) }
        expect(subject.score).to be 30
      end

      it '16 after 1 spare and 16 attempts with 6 pins down' do
        subject.attempt(8)
        subject.attempt(2)
        subject.attempt(4)
        subject.attempt(2)
        16.times { subject.attempt(0) }
        expect(subject.score).to be 20
      end

      it '300 after 10 attempts with 10 pins down' do
        12.times { subject.attempt(10) }
        expect(subject.score).to be 300
      end
 
 		end

 	end
end


