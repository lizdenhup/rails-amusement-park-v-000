require_relative "../rails_helper.rb"

describe 'Feature Test: Admin Flow', :type => :feature do

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
    admin_signup
  end

  it 'displays admin when logged in as an admin on user show page' do
    expect(page).to have_content("ADMIN")
  end

  it 'links to the attractions from the users show page when logged in as a admin' do
    expect(page).to have_content("See attractions")
  end

  it 'has a link from the user show page to the attractions index page when in admin mode' do
    click_link('See attractions')
    expect(page).to have_content("#{@teacups.name}")
    expect(page).to have_content("#{@rollercoaster.name}")
    expect(page).to have_content("#{@ferriswheel.name}")
  end

  it 'allows admins to add an attraction from the index page' do
    click_link('See attractions')
    expect(page).to have_content("New Attraction")
  end

  it 'allows admins to add an attraction' do
    click_link('See attractions')
    click_link("New Attraction")
    expect(current_path).to eq('/attractions/new')
    fill_in("attraction[name]", :with => "Haunted Mansion")
    fill_in("attraction[min_height]", :with => "32")
    fill_in("attraction[happiness_rating]", :with => "2")
    fill_in("attraction[nausea_rating]", :with => "1")
    fill_in("attraction[tickets]", :with => "4")
    click_button('Create Attraction')
    expect(current_path).to eq("/attractions/4")
    expect(page).to have_content("Haunted Mansion")
  end

  it "has link to attraction/show from attraction/index page for admins" do
    click_link('See attractions')
    expect(page).to have_content("Show #{@ferriswheel.name}")
  end

  it "does not suggest that admins go on a ride" do
    click_link('See attractions')
    expect(page).to_not have_content("Go on #{@ferriswheel.name}")
  end

  it "links to attractions/show page from attractions/index" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(current_path).to eq("/attractions/1")
  end

  it "does not suggest that an admin go on a ride from attractions/show page" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(page).to_not have_content("Go on this ride")
  end

  it "has a link for admin to edit attraction from the attractions/show page" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(page).to have_content("Edit Attraction")
  end

  it "links to attraction/edit page from attraction/show page when logged in as an admin" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    click_link("Edit Attraction")
    expect(current_path).to eq("/attractions/1/edit")
  end

  it "updates an attraction when an admin edits it" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    click_link("Edit Attraction")
    fill_in("attraction[name]", :with => "Nitro")
    click_button("Update Attraction")
    expect(current_path).to eq("/attractions/1")
    expect(page).to have_content("Nitro")
  end
end
