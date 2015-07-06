describe "GET /" do
  it "display welcome page" do
    visit root_path
    expect(page).to have_css("section h1", text: "Track your Bowling Scores")    
  end

  context "starts game" do
    it "starts game" do
      visit root_path
      click_link("btn-start")
      expect(page).to have_content("Round 1")
      expect(page).to have_content("Ball 1")
    end

    it "has 10 pins available" do
      visit game_path(1,1)

      expect(page).to have_css('a.btn_pins', count: 10)
    end
  end
end