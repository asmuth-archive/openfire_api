class OpenfireApi::UserService
	
	@@api_path = "plugins/userService/userservice"
	
	class HTTPException < StandardError; end
	class InvalidResponseException < StandardError; end
	class UserServiceDisabledException < StandardError; end
	class RequestNotAuthorisedException < StandardError; end
	class IllegalArgumentException < StandardError; end
	class UserNotFoundException < StandardError; end
	class UserAlreadyExistsException < StandardError; end
	
	def initialize(options=Hash.new)
		@options = { :path => @@api_path }.merge(options)
	end
	
	def add_user!(opts)
		submit_request(opts.merge(:type => :add))
	end
	
	def delete_user!
		submit_request(opts.merge(:type => :delete))
	end
	
	def update_user!
		submit_request(opts.merge(:type => :update))
	end
	
	def lock_user!
		submit_request(opts.merge(:type => :disable))
	end
	
	def unlock_user!
		submit_request(opts.merge(:type => :enable))
	end
	
private
	
	def build_query(params)				
		"#{build_query_uri.to_s}?#{build_query_params(params)}"
	end
	
	def build_query_uri
		uri = URI.parse(@options[:url])
		uri.path = File.join(uri.path, @@api_path)
		uri
	end
	
	def build_query_params(params)
		params.merge!(:secret => @options[:secret])
		params.to_a.map{ |p| "#{p[0]}=#{p[1]}" }.join('&')	
	end
	
	def submit_request(params)
    uri = build_query_uri
    http = Net::HTTP.new(uri.host, uri.port)
    resp, data = http.get("#{uri.path}?#{build_query_params(params)}", nil)
    return data
	rescue
	  raise HTTPException
	end
	
#	def parse_response(xml)
#    begin
#      doc = Nokogiri::XML(xml)
#      error_code = doc.xpath('//Response/ErrorCode').attribute('value').to_s.to_i
#      entries_as_hash = Hash.new
#      doc.xpath('//Response//DataRecord//Entry').each do |entry|
#        key = entry.xpath('Key').attribute('value').to_s
#        value = entry.xpath('Value').attribute('value').to_s
#        entries_as_hash[key] = value
#      end
#    rescue
#      raise PaybackClient::InvalidXMLException
#    else
#      check_error_code!(error_code)
#      return entries_as_hash
#    end
#  end
#	
	
end	
