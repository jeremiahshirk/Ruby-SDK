require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'

describe Base do
  before :each do
    @prod = Contact.new(use_production: true)
    @prod_auth_token = Contact.new(
      use_production: true, loglevel: Logger::DEBUG)
    @prod_auth_token.validation = 'token'
    @sub = SubAccounts.new(use_production: true, loglevel: Logger::DEBUG)
    @temp_accts = []
  end

  after :each do
    @temp_accts.each {|id| @sub.delete(id)}
  end

  it 'should get a new authToken' do
    token = @prod.new_auth_token
    token.should match /[A-Z0-9]{23,26}/
  end

  it 'should create implicit API GET methods' do
    contacts = @prod.contacts
    contacts.class.should == Array
  end

  it 'should create implicit API POST methods' do
    contacts = @prod.contacts
    contact_id = contacts[1]['contactId']
    response = @prod.edit(contact_id)
    response['status'].should == 'ok'
  end

  it 'should calculate the right checksum' do
    checksum = @prod.checksum 'notReallyASecret', {key2: "foo", key1: "bar"}
    checksum.should == 'ML1TdJ/wQc06CdIREtddB19wsKM='
  end

  it 'should raise an exception with non-Hash options argument to get_raw' do
    expect {
      @prod.get_raw('fakeAction', [])
    }.to raise_exception
  end

  it 'should raise an exception with non-Hash options argument to post_raw' do
    expect {
      @prod.post_raw('fakeAction', [])
    }.to raise_exception
  end

  it 'should pass a block to a post method' do
    temp = temp_name
    # add a test sub account
    args = {firstName: 'Test', lastName: 'User', email: "#{temp}@test.com",
            password: temp, group: temp}
    result = @prod.post('addSubAccount', args) do |x|
      @temp_accts << x['data']['userId']
      x['status'].should == 'ok'
    end
  end

  it 'should make a query using auth token authentication' do
    contacts = @prod_auth_token.contacts
    contacts.class.should == Array    
  end

  it 'should make a query with a bad auth mechanism' do
    prod_bad = Contact.new(
      use_production: true, loglevel: Logger::DEBUG)
    prod_bad.validation = 'no_such_auth'
    expect {
      prod_bad.contacts
    }.to raise_exception
  end

end