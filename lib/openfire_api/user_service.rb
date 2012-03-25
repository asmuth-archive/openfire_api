class OpenfireApi::UserService

  @@api_path = "plugins/userService/userservice"
  @@api_exceptions = %w(UserServiceDisabled RequestNotAuthorised IllegalArgumentException UserNotFoundException UserAlreadyExistsException)

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

  def delete_user!(opts)
    submit_request(opts.merge(:type => :delete))
  end

  def update_user!(opts)
    submit_request(opts.merge(:type => :update))
  end

  def lock_user!(opts)
    submit_request(opts.merge(:type => :disable))
  end

  def unlock_user!(opts)
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
    data = submit_http_request(build_query_uri, build_query_params(params))
    parse_response(data)
  end

  def submit_http_request(uri, params)
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.get("#{uri.path}?#{params}")
    end
    return res.body
  rescue Exception => e
    raise HTTPException, e.to_s
  end

  def parse_response(data)
    error = data.match(/<error>(.*)<\/error>/)
    if error && @@api_exceptions.include?(error[1])
      raise eval("#{error[1].gsub('Exception', '')}Exception")
    end
    raise InvalidResponseException unless data.match(/<result>ok<\/result>/)
    return true
  end

end
