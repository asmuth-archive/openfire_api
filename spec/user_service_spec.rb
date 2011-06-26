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
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?type=add&username=user&password=pw&secret=bigsecret", :body => "<result>ok</result>")
		@user_service.send(:submit_request, :type => :add, :username => "user", :password => "pw").should == true
	end
	
	it "should handle the error: user service disabled" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?username=user1&type=disable&secret=bigsecret", :body => "<error>UserServiceDisabled</error>")
		lambda{ @user_service.lock_user!(:username => "user1") }.should raise_error(OpenfireApi::UserService::UserServiceDisabledException)
	end
	
	it "should handle the error: request not authorized" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?username=user1&type=disable&secret=bigsecret", :body => "<error>RequestNotAuthorised</error>")
		lambda{ @user_service.lock_user!(:username => "user1") }.should raise_error(OpenfireApi::UserService::RequestNotAuthorisedException)
	end
	
	it "should handle the error: illegal argument" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?username=user1&type=disable&secret=bigsecret", :body => "<error>IllegalArgumentException</error>")
		lambda{ @user_service.lock_user!(:username => "user1") }.should raise_error(OpenfireApi::UserService::IllegalArgumentException)
	end
	
	it "should handle the error: user not found" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?username=user1&type=disable&secret=bigsecret", :body => "<error>UserNotFoundException</error>")
		lambda{ @user_service.lock_user!(:username => "user1") }.should raise_error(OpenfireApi::UserService::UserNotFoundException)
	end
	
	it "should handle the error: user already exists" do
		FakeWeb.register_uri(:get, "http://fakehost.int:2323/plugins/userService/userservice?username=user1&type=disable&secret=bigsecret", :body => "<error>UserAlreadyExistsException</error>")
		lambda{ @user_service.lock_user!(:username => "user1") }.should raise_error(OpenfireApi::UserService::UserAlreadyExistsException)
	end


end
