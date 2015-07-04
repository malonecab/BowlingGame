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

      it 'should be 0 after 20 attempts with 0 pins down' do
        20.times { subject.attempt(0) }
        expect(subject.score).to be 0
      end

      it 'should be 20 after 20 attempts with 1 pins down' do
        20.times { subject.attempt(1) }
        expect(subject.score).to be 20
      end

 		end

 	end


end


