require 'httparty'
require 'digest/md5'

# Manage user keys and authentication
class User < MonitisClient

  # === Get user key
  # DEPRECATED
  #
  # === Required arguments
  # * username
  # * password
  def User.getUserKey(username, password)
    query = { :action => "userkey", :userName => username,
              :password => password}
    res = get("userkey", query) { |x| x['userkey']}
  end

  # Get user's API Key
  #
  # === Required arguments
  # * username
  # * password
  def apikey(username, password)
    md5 = Digest::MD5.new
    digest = md5.update(password).hexdigest

    query = { action: 'apikey', userName: username, password: digest }
    get('apikey', query) { |x| x['apikey'] }
  end

  # Get user's secret key
  #
  # === Required arguments
  # * apikey - User's API key
  def secretkey(apikey)
    get 'secretkey', {apikey: apikey} { |x| x['secretkey'] }
  end

  # Get an auth token for the user
  #
  # === Required arguments
  # * secretkey - User's secret
  def authToken(secretkey)
    # get 'authToken', {secretkey: secretkey} { |x| x['authToken'] }
    new_auth_token
  end

end