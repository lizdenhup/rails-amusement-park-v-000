require_relative "../rails_helper.rb"

describe 'Feature Test: Go on a Ride', :type => :feature do

  before :each do
    @rollercoaster = Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
    @ferriswheel = Attraction.create(
      :name => "Ferris Wheel",
      :tickets => 2,
      :nausea_rating => 2,
      :happiness_rating => 1,
      :min_height => 28
    )
    @teacups = Attraction.create(
      :name => "Teacups",
      :tickets => 1,
      :nausea_rating => 5,
      :happiness_rating => 1,
      :min_height => 28
    )
    visit_signup
    user_signup
  end

  it 'has a link from the user show page to the attractions index page' do
    expect(page).to have_content("See attractions")
    click_link('See attractions')
  end

  it 'links from the user show page to the attractions index page' do
    click_link('See attractions')
    expect(current_path).to eq('/attractions')
  end

  it 'prevents users from editing/deleting/adding rides on the index page' do
    click_link('See attractions')
    expect(current_path).to eq('/attractions')
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
    expect(page).to_not have_content("new attraction")
  end

  it 'has titles of the rides on the attractions index page' do
    click_link('See attractions')
    expect(page).to have_content("#{@ferriswheel.name}")
    expect(page).to have_content("#{@rollercoaster.name}")
  end

  it "has links on the attractions index page to the attractions' show pages" do
    click_link('See attractions')
    expect(page).to have_content("Go on #{@ferriswheel.name}")
    expect(page).to have_content("Go on #{@rollercoaster.name}")
  end

  it "links from the attractions index page to the attractions' show pages" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(current_path).to eq("/attractions/2")
  end

  it 'prevents users from editing/deleting a ride on the show page' do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
  end

  it "has a button from the attraction show page to go on the ride" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(current_path).to eq("/attractions/2")
    expect(page).to have_button("Go on this ride")
  end

  it "clicking on 'Go on this ride' redirects to user show page" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(current_path).to eq("/users/1")
  end

  it "clicking on 'Go on this ride' updates the users ticket number" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("Tickets: 13")
  end

  it "clicking on 'Go on this ride' updates the users mood" do
    click_link('See attractions')
    click_link("Go on #{@teacups.name}")
    click_button("Go on this ride")
    expect(page).to have_content("sad")
  end

  it "when the user is tall enough and has enough tickets, clicking on 'Go on this ride' displays a thank you message" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("Thanks for riding the #{@ferriswheel.name}!")
  end

  it "when the user is too short, clicking on 'Go on this ride' displays a sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:height => 10)
    click_link('See attractions')
    click_link("Go on #{@teacups.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You are not tall enough to ride the #{@teacups.name}")
    expect(page).to have_content("happy")
  end

  it "when the user doesn't have enough tickets, clicking on 'Go on this ride' displays a sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:tickets => 1)
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You do not have enough tickets to ride the #{@ferriswheel.name}")
    expect(page).to have_content("Tickets: 1")
  end

  it "when the user is too short and doesn't have enough tickets, clicking on 'Go on this ride' displays a detailed sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:tickets => 1, :height => 30)
    click_link('See attractions')
    click_link("Go on #{@rollercoaster.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You are not tall enough to ride the #{@rollercoaster.name}")
    expect(page).to have_content("You do not have enough tickets to ride the #{@rollercoaster.name}")
    expect(page).to have_content("Tickets: 1")
  end
end