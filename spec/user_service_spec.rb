require ::File.expand_path('../spec_helper', __FILE__)

describe "User Service" do

	before :all do
		@user_service = OpenfireApi::UserService.new(:url => "http://fakehost.int:2323/", :secret => "bigsecret")
	end
	
	it "should build query urls" do
		url = @user_service.send(:build_query, :type => :add, :username => "user", :password => "pw")
		url.should == "http://fakehost.int:2323/plugins/userService/userservice?type=add&username=user&password=pw&secret=bigsecret"
	end

end
