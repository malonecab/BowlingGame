describe "GET /" do
  it "display welcome page" do
    visit root_path
    expect(page).to have_content "Track your Bowling Scores"
  end
end