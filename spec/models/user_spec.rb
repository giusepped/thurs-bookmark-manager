require './app/data_mapper_setup'


describe User do
	let!(:user) do
   User.create(email: 'test@test.com', password: 'secret1234',
               password_confirmation: 'secret1234')
  end

	it "authenticates when given a valid email address and password" do
		authenticated_user = User.authenticate(user.email, user.password)
		expect(authenticated_user).to eq user
	end

  it 'does not authenticate when the password is wrong' do
    authenticated_user = User.authenticate(user.email, 'wrongstupidpassword')
    expect(authenticated_user).to eq nil
  end
end
