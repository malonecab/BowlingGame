describe "GET /" do
  it "display welcome page" do
    visit root_path
    expect(page).to have_css("section h1", text: "Track your Bowling Scores")    
  end

  context "start game" do
    it "show actual Round and Ball" do
      visit root_path
      click_link("btn-start")
      expect(page).to have_content("Round 1")
      expect(page).to have_content("Ball 1")
    end

    it "has 10 pins available" do
      visit new_game_path
      expect(page).to have_css('div.btn_pins', count: 11)
    end
  end

  context "throw the first ball" do
    it "kock down 3 pins" do
      visit new_game_path
      click_link("btn-pins-3")
      expect(page).to have_content("Round 1")
      expect(page).to have_content("Ball 2")
      expect(page).to have_css('div.btn_pins', count: 8)
    end
  end
end