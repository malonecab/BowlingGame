require 'rails_helper'

RSpec.describe Frame, type: :model do
   
  subject { Frame.new }

  describe "associations" do
    it { should be_embedded_in(:bowling_game) }
  end

  describe "public class methods" do
    context "responds to its methods" do
      it { expect(subject).to respond_to(:hit) }
    end

  end

  describe "Model validations" do
    context "successfully" do
      it 'when only 1 hit' do
        subject.hit(0)
        expect(subject).to be_valid
      end
      it 'when only 2 hits' do
        2.times { subject.hit(0) }
        expect(subject).to be_valid
      end   
    end

    context "with error" do
      it 'when only 2 hits' do
        3.times { subject.hit(0) }
        expect(subject).to_not be_valid
      end
    end

  end
end


