require 'spec_helper'
require 'monitis-SDK'

describe User do
  before :each do
    @apikey = ENV['MONITIS_APIKEY']
    @secretkey = ENV['MONITIS_SECRETKEY']
    @username = ENV['MONITIS_USER']
    @password = ENV['MONITIS_PASS']
    @user = User.new use_production: true
  end

  it 'should be able to get the API key' do
    @user.apikey(@username, @password).should == @apikey
  end


  it 'should be able to get the secret key' do
    @user.secretkey(@apikey).should == @secretkey
  end

  it 'should be able to get an authtoken' do
    authtoken = @user.authToken @secretkey
    authtoken.should match /[A-Z0-9]{23,26}/
  end

  it 'should get the userkey for a user' do
    key = @user.userkey @username, @password
    key.should match /[A-Z0-9]{23,26}/
  end

end
