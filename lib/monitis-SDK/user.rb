require 'httparty'
require 'digest/md5'

class User < MonitisClient
      
  #  getUserKey is unique in that it doesn't use standard authentication
  def User.getUserKey(username, password)
    query = { :action => "userkey", :userName => username,
              :password => password}
    res = get("userkey", query) { |x| x['userkey']}
  end

  def apikey(username, password)
    md5 = Digest::MD5.new
    digest = md5.update(password).hexdigest

    query = { action: 'apikey', userName: username, password: digest }
    get('apikey', query) { |x| x['apikey'] }
  end

  def secretkey(apikey)
    get 'secretkey', {apikey: apikey} { |x| x['secretkey'] }
  end

  def authToken(secretkey)
    # get 'authToken', {secretkey: secretkey} { |x| x['authToken'] }
    new_auth_token
  end

end