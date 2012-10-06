require 'monitis-SDK'
require 'securerandom'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

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
    result = @notification.notification_rules(args)
    result.class.should == Array
  end

  it 'should add notification rules' do
    result = @notification.add_notification_rule(
      @monitor_id, 'custom', 'always', 0, 0, 5, 'equals', contactId: @contact_id,
      paramName: 't', paramValue: '1')
    result['status'].should == 'ok'
  end

  it 'should delete notification rules' do
    # @notification.debug = true
    @notification.add_notification_rule(
      @monitor_id, 'custom', 'always', 0, 0, 5, 'equals', contactId: @contact_id,
      paramName: 't', paramValue: '1')
    result = @notification.delete_notification_rule(
      @contact_id, @monitor_id, 'custom')
    result['status'].should == 'ok'
  end

end