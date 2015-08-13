require './app/data_mapper_setup'

feature 'User sign up and sign in' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  let(:user) do
    build(:user)
  end

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

  scenario "with correct credentials" do
    sign_up(user)
    sign_in(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(user)
    visit '/sessions/new'
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end

  def sign_up(user)
    visit '/users/new'

    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

end

# feature "User sign in" do

#   scenario "with correct credentials" do
#     user = build(:user)
#     sign_up(user)
#     sign_in(user)
#     expect(page).to have_content "Welcome, #{user.email}"
#   end

#   def sign_in(user)
#     visit '/sessions/new'
#     fill_in :email,    with: user.email
#     fill_in :password, with: user.password
#     click_button 'Sign in'
#   end

#   def sign_up(user)
#     visit '/users/new'

#     fill_in :email,    with: user.email
#     fill_in :password, with: user.password
#     fill_in :password_confirmation, with: user.password_confirmation
#     click_button 'Sign up'
#   end
# end