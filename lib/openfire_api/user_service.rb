class OpenfireApi::UserService
	
	@@api_path = "plugins/userService/userservice"
	
	def initialize(options=Hash.new)
		@options = { :path => @@api_path }.merge(options)
	end
	
private
	
	def build_query(params)		
		params.merge!(:secret => @options[:secret])
		uri = URI.parse(@options[:url])
		uri.path = File.join(uri.path, @@api_path)
		uri = uri.to_s + "?"
		uri += params.to_a.map{ |p| "#{p[0]}=#{p[1]}" }.join('&')	
	end
	
	
end	
