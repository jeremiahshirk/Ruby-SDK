$LOAD_PATH << './lib'
require 'test/unit'
require 'monitis-SDK'

class TestMonitisSdk < Test::Unit::TestCase
  def setup
    @apikey = ENV['MONITIS_APIKEY']
    @secretkey = ENV['MONITIS_SECRETKEY']
    @username = ENV['MONITIS_USER']
    @password = ENV['MONITIS_PASS']
    @user = User.new(@apikey, @secretkey, true, false)

  end

  def test_userKey
    key = @user.getUserKey(@username, @password)
    assert_equal 'M6I2KA0TPEU9P5IJUS1SE0SN5', key
  end

  def test_apikey
    res = @user.apikey(@username, @password)
    assert_equal @apikey, res
  end

  def test_secretkey
    res = @user.secretkey(@apikey)
    assert_equal @secretkey, res
  end
end
