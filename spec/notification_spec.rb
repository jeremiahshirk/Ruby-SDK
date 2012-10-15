require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'

describe Notification do
  before :each do
    @notification = Notification.new
    # create custom monitor
    @custom = CustomMonitors.new
    @monitor_id = @custom.add('t:t:s:4', temp_name, 't')['data']
    @contact_id = Contact.new.contacts.first['contactId']
  end

  after :each do
    @custom.delete(@monitor_id)
  end

  it 'should get notification rules' do
    args = {monitorId: @monitor_id, monitorType: 'custom'}
    result = @notification.rules(args)
    result.class.should == Array
  end

  it 'should add notification rules' do
    result = @notification.add(@monitor_id, 'custom', 'always', 0, 0, 5,
      'equals', contactId: @contact_id, paramName: 't', paramValue: '1')
    result['status'].should == 'ok'
  end

  it 'should delete notification rules' do
    # @notification.debug = true
    @notification.add(@monitor_id, 'custom', 'always', 0, 0, 5, 'equals',
      contactId: @contact_id, paramName: 't', paramValue: '1')
    result = @notification.delete(@contact_id, @monitor_id, 'custom')
    result['status'].should == 'ok'
  end

end