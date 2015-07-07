describe "GET /" do
  it "display welcome page" do
    visit root_path
    expect(page).to have_css("section h1", text: "Track your Bowling Scores")    
  end
end

describe "PUT /game" do

  context "start game" do
    it "show actual Round and Ball" do
      visit root_path
      click_link("btn-start")
      expect(page).to have_content("Round 1")
      expect(page).to have_content("ball 1")
    end

    it "has 10 pins available" do
      visit create_game_path
      expect(page).to have_css('div.btn_pins', count: 11)

      expect(page.find('#btn-pins-0')[:href]).to match(/\/round\/1\/ball\/1\/hits\/0/)
      expect(page.find('#btn-pins-10')[:href]).to match(/\/round\/1\/ball\/1\/hits\/10/) 
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
      expect(page).to have_content("ball 2")
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

  context "special shoots" do
    it "strike if 10 pins knocked down" do
      visit create_game_path
      click_link("btn-pins-10")
      notice_text = find(:css, ".alert-box.round.success").text
      expect(notice_text).to include "STRIKE!"
    end

    it "score if 10 pins knocked down in a round" do
      visit create_game_path
      click_link("btn-pins-3")
      click_link("btn-pins-7")
      notice_text = find(:css, ".alert-box.round.success").text
      expect(notice_text).to include "SPARE!"
    end
  end

  describe "finish game" do
    context "without extra balls" do
      it "shows game finished" do
        visit create_game_path
        10.times {
          click_link("btn-pins-4")
          click_link("btn-pins-6")
        }
        expect(page).to have_content("GAME FINISHED!")
      end

      it "shows final score" do
        visit create_game_path
        10.times {
          click_link("btn-pins-0")
          click_link("btn-pins-8")
        }
        expect(page).to have_content("Your final score is 80 points")
      end    
    end

    context "with 2 extra balls" do
      it "shows the frist one when strike in last round" do
        visit create_game_path
        9.times {
          click_link("btn-pins-0")
          click_link("btn-pins-8")
        }
        click_link("btn-pins-10")
        notice_text = find(:css, ".alert-box.round.success").text
        expect(notice_text).to include "STRIKE!"
        expect(page).to have_content("Extra ball 1")
      end

      it "shows the second after the first one" do
        visit create_game_path
        9.times {
          click_link("btn-pins-0")
          click_link("btn-pins-8")
        }
        click_link("btn-pins-10")
        click_link("btn-pins-5")
        
        expect(page).to have_content("Extra ball 2")
      end

      it "perfect game with 300 points!" do
        visit create_game_path
        12.times { click_link("btn-pins-10") }
        expect(page).to have_content("Your final score is 300 points")
      end
    end

  end

end