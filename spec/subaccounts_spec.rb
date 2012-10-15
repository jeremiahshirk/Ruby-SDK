require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'

describe Agents do
  before :each do
    @sub = SubAccounts.new(use_production: true)
    @layout = Layout.new(use_production: true)
    temp = temp_name
    
    # add a test sub account
    acct = @sub.add('Test', 'User', "#{temp}@test.com", temp, temp)
    @acct_id = acct['data']['userId']
    @temp_accts = [@acct_id]
    
    # add a page to the subaccount
    @page_name = @layout.pages.first['title']
    @sub.add_pages(@acct_id, @page_name)
  end

  after :each do
    # delete test subaccounts
    @temp_accts.each {|id| @sub.delete(id)}
  end

  it 'should add a sub account' do
    temp = temp_name
    result = @sub.add('Test', 'User', "#{temp}@test.com", temp, temp)
    result['status'].should == 'ok'
    @temp_accts << result['data']['userId']
  end

  it 'should add a page to a sub account' do
    result = @sub.add_pages(@acct_id, @layout.pages.first['title'])
    result.status.should == 'ok'
  end

  it 'should delete a sub account' do
    result = @sub.delete(@temp_accts.pop)
    result.status.should == 'ok'
  end

  it 'should delete a page from a sub account' do
    result = @sub.delete_pages(@acct_id, @page_name)
    result.status.should == 'ok'
  end

  it 'should get a list of all sub accounts' do
    result = @sub.subaccounts
    result.keep_if {|x| x['id'] == @acct_id}.length.should > 0
  end

  it 'should get a list of all sub accounts pages' do
    result = @sub.pages
    result.keep_if {|x| x['id'] == @acct_id}.length.should > 0
  end
end
