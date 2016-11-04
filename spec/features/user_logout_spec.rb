require_relative "../rails_helper.rb"

describe 'Feature Test: User Signout', :type => :feature do

  it 'has a link to log out from the users/show page' do
    visit_signup
    user_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after logging out' do
    visit_signup
    user_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked" do
    visit_signup
    user_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end

  it 'has a link to log out from the users/show page when user is an admin' do
    visit_signup
    admin_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after admin logs out when user is an admin' do
    visit_signup
    admin_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked as admin" do
    visit_signup
    admin_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end
end