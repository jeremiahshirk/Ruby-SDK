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

# Manage User's sub accounts
class SubAccounts < MonitisClient

  # Add a new sub account
  #
  # === Required arguments
  # * first - First name of the sub account owner
  # * last - last name of the sub account owner
  # * email - email address to be used as user name for the sub account
  # * password - password of the sub account
  # * group - group of the sub account
  def add(first, last, email, password, group)
    args = {firstName: first, lastName: last, email: email,
            password: password, group:group}
    post('addSubAccount', args)
  end

  # Add new pages for the specified sub account
  #
  # === Required arguments
  # * id - user id of the specified subaccount to add pages to
  # * pages - Pages names to share with sub account, as an array
  #   or semicolon separated string
  #
  # === Optional arguments
  def add_pages(id, pages)  
    pages = pages.join(',') if pages.class == Array
    args = {userId: id, pageNames: pages}
    post('addPagesToSubAccount', args)
  end

  # Delete a sub account
  #
  # === Required arguments
  # * id - User id of the sub account to delete
  def delete(id)
    post('deleteSubAccount', userId: id)
  end

  # Delete pages from the specified sub account
  #
  # === Required arguments
  # * id - user ID of the sub account to delete pages from
  # * pages - Pages names to remove from the sub account, as an array
  #   or semicolon separated string
  #
  # === Optional arguments
  def delete_pages(id, pages)
    pages = pages.join(',') if pages.class == Array
    args = {userId: id, pageNames: pages}
    post('deletePagesFromSubAccount', args)
  end

  # Get a list of a user's sub accounts
  def subaccounts()
    get('subAccounts')
  end

  # Get all pages for a user's sub accounts
  def pages()
    get('subAccountPages')
  end
end