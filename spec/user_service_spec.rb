require ::File.expand_path('../spec_helper', __FILE__)

describe "User Service" do

	before :all do
		@user_service = OpenfireApi::UserService.new(:url => "http://fakehost.int:2323/", :secret => "bigsecret")
	end
	
	it "should build query urls" do
		url = @user_service.send(:build_query_uri)
		url.to_s.should == "http://fakehost.int:2323/plugins/userService/userservice"
	end
	
	it "should build query params" do
		params = @user_service.send(:build_query_params, :type => :add, :username => "user", :password => "pw")
		params.should == "type=add&username=user&password=pw&secret=bigsecret"
	end
	
	it "should build queries" do
		url = @user_service.send(:build_query, :type => :add, :username => "user", :password => "pw")
		url.should == "http://fakehost.int:2323/plugins/userService/userservice?type=add&username=user&password=pw&secret=bigsecret"
	end
	
	it "should submit requests" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?type=add&username=user&password=pw&secret=bigsecret", :body => "fnord")
		data = @user_service.send(:submit_request, :type => :add, :username => "user", :password => "pw")
		data.should = "fnord"
	end

end
