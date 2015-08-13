require './app/data_mapper_setup'

 
describe User do
	let(:user) do
		user = build(:user)
	end

	it "authenticates when given a valid email address and password" do
		authenticated_user = User.authenticate(user)
		expect(authenticated_user).to eq user
	end

end
