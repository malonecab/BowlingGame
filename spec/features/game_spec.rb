describe "GET /" do
  it "display welcome page" do
    visit root_path
    expect(page).to have_css("section h1", text: "Track your Bowling Scores")    
  end

  it "starts game" do
  	visit root_path
  	click_link("btn-start")
  	expect(page).to have_content("Round 1")

  end
end