require './app/data_mapper_setup'

feature 'User sign up and sign in' do

  let(:user) do
    build(:user)
  end

context "Sign up" do
  scenario 'I can sign up as a new user' do
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    user = build(:user, password_confirmation: "wrong")
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'requires email not to be empty' do
    user = build(:user, email: "")
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email cannot be empty')
  end

  scenario 'cannot register user twice' do
    sign_up(user)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

end

  context "Sign in" do

    scenario "with correct credentials" do
      sign_up(user)
      sign_in(user)
      expect(page).to have_content "Welcome, #{user.email}"
    end

  end

  context "Sign out" do

    scenario "while being signed in the user can sign out" do
      sign_up(user)
      sign_in(user)
      click_button "Sign out"
      expect(page).to have_content "You are signed out"
    end

  end

end

