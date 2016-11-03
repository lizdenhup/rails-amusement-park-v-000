require_relative "../rails_helper.rb"

describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully signs up as non-admin' do
    visit_signup
    expect(current_path).to eq('/users/new')
    user_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Amy Poehler")
    expect(page).to have_content("Mood")
    expect(page).to have_content("happy")
    expect(page).to have_content("15")
    expect(page).to have_content("58")
  end

  it "on sign up, successfully adds a session hash" do
    visit_signup
    user_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as non-admin' do
    visit_signin
    expect(current_path).to eq('/signin')
    user_login
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Mindy")
    expect(page).to have_content("Mood")
    expect(page).to have_content("happy")
    expect(page).to have_content("10")
    expect(page).to have_content("50")
  end

  it "on log in, successfully adds a session hash" do
    visit_signin
    user_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'prevents user from viewing user show page and redirects to home page if not logged in' do
    @mindy = User.create(
      name: "Mindy",
      password: "password",
      happiness: 3,
      nausea: 2,
      tickets: 10,
      height: 50
    )
    visit '/users/1'
    expect(current_path).to eq('/')
    expect(page).to have_content("Sign Up")
  end

  it 'successfully signs up as admin' do
    visit_signup
    expect(current_path).to eq('/users/new')
    admin_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on sign up for admin, successfully adds a session hash" do
    visit_signup
    admin_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as admin' do
    visit_signin
    expect(current_path).to eq('/signin')
    admin_login
    expect(current_path).to eq('/users/2')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on log in, successfully adds a session hash to admins" do
    visit_signin
    admin_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

end