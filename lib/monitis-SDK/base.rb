require 'httparty'
require 'crack'
require 'openssl'
require 'base64'
require 'logger'

# Use Syck engine for parsing JSON responses
YAML::ENGINE.yamler = "syck"

# Base class for communcation with Monitis API
class Base 

  # default URL for Monitis API
  BASE_URL = "http://www.monitis.com/api"
  # default Custom URL for Monitis API
  CUSTOM_BASE_URL = "http://www.monitis.com/customMonitorApi"
  # default URL for Monitis API sandbox
  SANDBOX_URL = "http://sandbox.monitis.com/api"
  # default Custom URL for Monitis API sandbox
  CUSTOM_SANDBOX_URL = "http://sandbox.monitis.com/customMonitorApi"
  # Monitis API version
  VERSION = "2"
  # Default log level
  LOGLEVEL = Logger::DEBUG
  # Default log file
  LOGFILE = "monitis-SDK.log"
  # Set Monitis.debug to true to enable debugging output
  debug = false

  # User's Monitis API Key
  attr_accessor :apikey
  # User's Monitis secret key
  attr_accessor :secretkey
  # Auth token for user
  attr_accessor :authtoken
  # The API endpoint
  attr_accessor :endpoint
  # Type of API validation, either 'token' or 'HMACSHA1'
  attr_accessor :validation
  # Print debugging information, if true
  attr_accessor :debug

  # Create a new instance
  #
  # === Required arguments
  # * apikey - User's Monitis API key
  # * secretkey - User's Monitis secret key
  #
  # === Optional arguments
  # * use_production - Use production endpoint if true, sandbox otherwise.
  #   Default is false.
  # * use_custom_monitor - Use the Custom Monitor endpoint if true, or the
  #   standard endpoint otherwise. Default is false.
  def initialize(apikey, secretkey, use_production = false, 
                 use_custom_monitor = false, options = {})
    @apikey, @secretkey = apikey, secretkey
    @validation = 'HMACSHA1'
    # @validation = 'token'
    if use_custom_monitor == false
      @endpoint = use_production ? BASE_URL : SANDBOX_URL
    else
      @endpoint = use_production ? CUSTOM_BASE_URL : CUSTOM_SANDBOX_URL
    end
    @authtoken = getAuthToken if @validation == 'token'

    # logging
    @logfile = options.fetch(:logfile, LOGFILE)
    @loglevel = options.fetch(:loglevel, LOGLEVEL)
    @logger = Logger.new(@logfile)
    @logger.level = @loglevel

  end

  # Monitis API HTTP GET, unparsed response
  #
  # === Required arguments
  # * action - action parameter to Monitis API request
  #
  # === Optional arguments
  # * options - Hash containing key-value pairs corresponding to 
  #   Monitis API parameter names and values
  def get_raw(action, options={})
    unless options.instance_of? Hash
      raise "GET options must be Hash-like"
    end
    query = build_request(action, options)
    # @logger.debug("GET QUERY\n#{PP::pp(query, '')}")
    @logger.debug("GET #{action}(#{options})")
    pp query if @debug
    response = HTTParty.get @endpoint, query: query
    unless response.success?
      @logger.error("HTTP error: #{response}")
    end
    pp response if @debug
    response
  end

  # Monitis API HTTP GET, with parsed JSON response
  #
  # === Required arguments
  # * action - action parameter to Monitis API request
  #
  # === Optional arguments
  # * options - Hash containing key-value pairs corresponding to 
  #   Monitis API parameter names and values
  # * If an optional block is provided, it will be executed with
  #   the parsed JSON response as its argument. The result
  #   of that block will be returned by this method.
  def get(action, options = {})
    response = get_raw(action, options)
    parsed = raise_api_errors parse_response response
    # pp parsed if @debug
    if block_given?
      result = yield parsed
    else
      result = parsed
    end
    # File.open(@logfile, 'w+') do |f|
    #   PP::pp(result, f, 78)
    # end
    @logger.debug("RESPONSE\n#{PP::pp(result, '')}")
    monitis_result result
  end

  # Monitis API HTTP POST, unparsed response
  #
  # === Required arguments
  # * action - action parameter to Monitis API request
  #
  # === Optional arguments
  # * options - Hash containing key-value pairs corresponding to 
  #   Monitis API parameter names and values
  def post_raw(action, options = {})
    unless options.instance_of? Hash
      raise "POST options must be Hash-like"
    end
    body = build_request(action, options)
    # @logger.debug("POST BODY\n#{PP::pp(body, '')}")
    @logger.debug("POST #{action}(#{options})")
    # pp body if @debug
    response = HTTParty.post @endpoint, body: body
    unless response.success?
      @logger.error("HTTP error: #{response}")
    end
    if @debug
      pp response.request
      pp response.body
    end
    response
  end

  # Monitis API HTTP POST, with parsed JSON response
  #
  # === Required arguments
  # * action - action parameter to Monitis API request
  #
  # === Optional arguments
  # * options - Hash containing key-value pairs corresponding to 
  #   Monitis API parameter names and values
  # * If an optional block is provided, it will be executed with
  #   the parsed JSON response as its argument. The result
  #   of that block will be returned by this method.
  def post(action, options = {})
    response = post_raw(action, options)
    parsed = raise_api_errors parse_response response
    # pp parsed if @debug
    if block_given?
      result = yield parsed
    else
      result = parsed
    end
    @logger.debug("RESPONSE\n#{PP::pp(result, '')}")
    monitis_result result
  end

  # Base64-encoded RFC 2104-compliant HMAC signature of the parameters 
  # string encrypted with secret key
  def checksum(secretkey, request_params={})
    params = request_params.clone
    hmac_sha1 secretkey, params.each_pair.sort.join
  end

  # Get a new auth token for the instance's API and secret keys
  def new_auth_token()
    query = { action: 'authToken', apikey: @apikey, secretkey: @secretkey }
    res = HTTParty.get(@endpoint, query: query)
    parse_response(res).fetch("authToken")
  end

  private

  # # Guess which HTTP method the API call needs when picked up by missing_method
  # #
  # # === Required arguments
  # # * method_name
  # def guess_http_method(method_name)
  #   method_map = {
  #     :contactGroupList => :get,
  #     :downloadAgent => :post
  #   }
  #   exact_match = method_map.fetch method_name, nil
  #   if exact_match
  #     guess = exact_match
  #   elsif method_name.match /^(add|edit|delete|confirm|contact|suspend|activate)[A-Z]/
  #     guess = :post
  #   else
  #     guess = :get
  #   end
  #   guess
  # end

  # # Automatically convert missing methods into raw API calls
  # def method_missing( method_name, *args )
  #   # TODO, only accept if second arg is options hash
  #   puts "Auto-creating API method #{method_name}(#{args})"
  #   http_method = guess_http_method method_name
  #   if http_method == :get
  #     result = get(method_name, options=args.first || {})
  #   elsif http_method == :post
  #     result = post(method_name, options=args.first || {})
  #   else
  #     raise "Unknown HTTP method"
  #   end

  #   if block_given?
  #     result = yield result
  #   end
  #   result
  # end  

  def status_warning(r_hash)
    # return the warning message on any non-'ok' status
    if   ((r_hash.has_key?('status')) && (r_hash['status'] != 'ok'))
      result = r_hash['status']
    else
      result = nil
    end
    result
  end

  def raise_api_errors(monitis_response)
    # some valid API responses return JSON arrays
    # errors are always of the form {error: "message"}
    if monitis_response.class == Hash
      err = monitis_response.fetch('error', nil)
      raise  "Monitis API Error: #{err}" if err
      # warning = status_warning(monitis_response)
      # raise "Monitis API Warning: #{warning}" if warning
    end
    monitis_response
  end

  def monitis_result(instance)
    # if a result is a hash, append some convenience methods
    if instance.class == Hash
      def instance.status
        self['status']
      end

      def instance.is_ok?
        status == 'ok'
      end
    end
    instance
  end

  def parse_response(response)
    # TODO Raise an exception if crack fails
    # TODO Raise an exception if body is nil
    Crack::JSON.parse(response.body) if response.body
  end

  def hmac_sha1(key, message)
    digest = OpenSSL::Digest::Digest.new('sha1') 
    Base64::encode64(OpenSSL::HMAC.digest digest, key, message).rstrip
  end

  def build_request(action, options={})
    key = options.delete(:secretkey) || @secretkey
    options.merge!({
         :apikey => @apikey, :version => VERSION, :validation => @validation,
 	       :timestamp => Time.now.utc.strftime("%Y-%m-%d %H:%M:%S"),
         :action => action })

    if @validation == 'token'
      options.merge!(authToken: @authtoken)
    elsif @validation == 'HMACSHA1'
      options.merge!(checksum: checksum(key, options))
    else
      raise "Invalid validation method: #{@validation}"
    end

    options
  end
  
  def getAuthToken()
    @authtoken ||= new_auth_token
  end

end

# Extend the Base class with automatic keys
class MonitisClient < Base

  # Create new MonitisClient instance
  def initialize(options={})
    use_production = options.fetch(:use_production, false)
    use_custom_monitor = options.fetch(:use_custom_monitor, false)
    if use_production
      apikey_env_name = 'MONITIS_APIKEY'
      secretkey_env_name = 'MONITIS_SECRETKEY'
    else
      apikey_env_name = 'MONITIS_SANDBOX_APIKEY'
      secretkey_env_name = 'MONITIS_SANDBOX_SECRETKEY'
    end

    apikey = options.fetch(:apikey, ENV[apikey_env_name])
    secretkey = options.fetch(:apikey, ENV[secretkey_env_name])

    super(apikey, secretkey, use_production, use_custom_monitor)
  end
end

# Extend the Hash returned by many Monitis API calls
class MonitisResponse < Hash

  # Return status message
  def status()
    self['status']
  end

  # Return error message
  def error()
    self['error']
  end
end