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
      visit create_game_path
      expect(page).to have_css('div.btn_pins', count: 11)

      expect(page.find('#btn-pins-0')[:href]).to match(/\/round\/1\/ball\/2\/hits\/0/)
      expect(page.find('#btn-pins-10')[:href]).to match(/\/round\/2\/ball\/1\/hits\/10/) 
    end
  end

  context "throw the first ball" do
    it "and saved the hit" do
      visit create_game_path
      click_link("btn-pins-0")

      game_id = URI.parse(current_url).request_uri.split("/")[2]
      expect(BowlingGame.find(game_id).hits.size).to eq 1 
    end

    it "knocked down 3 pins" do
      visit create_game_path
      click_link("btn-pins-3")
      expect(page).to have_content("Round 1")
      expect(page).to have_content("Ball 2")
      expect(page).to have_css('div.btn_pins', count: 8)
    end

    it "page shows knocked down und remain standing pins" do
      visit create_game_path
      click_link("btn-pins-2")
      notice_text = find(:css, ".alert-box.round.success").text
      expect(notice_text).to include "2 pins knocked down"
      expect(notice_text).to include "8 still up"
    end     
  end
end