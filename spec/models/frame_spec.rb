require 'rails_helper'

RSpec.describe Frame, type: :model do
   
 	subject { Frame.new }

 	describe "associations" do
    it { should be_embedded_in(:bowling_game) }
  end

end


