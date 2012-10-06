require 'monitis-SDK'
require 'securerandom'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe Contact do
  before :each do
    @contact = Contact.new
    # @contact.debug = true
    result = @contact.add(
      'First', 'Last', "#{temp_name}@test.com", 1, -300)
    begin
      @test_contact_ids = [result['data']['contactId']]
    rescue
      puts 'Before failed to create a new contact'
      @test_contact_ids = []
    end
  end

  after :each do
    @test_contact_ids.each { |id| @contact.delete(contactId: id)}
  end

  it 'should be able to add a contact' do
    result = @contact.add(
      'First', 'Last', "#{temp_name}@test.com", 1, -300)
    @test_contact_ids << result['data']['contactId']
    result['status'].should == 'ok'
  end

  it 'should be able to delete a contact' do
    args = {contactId: @test_contact_ids.first}
    result = @contact.delete(args)
    result['status'].should == 'ok'
  end

  it 'should be able to edit a contact' do
    result = @contact.edit(@test_contact_ids.first, firstName: 'Foo')
    result['status'].should == 'ok'
  end

  it 'should be able to confirm a contact' do
    result = @contact.add(
    'First', 'Last', "#{temp_name}@test.com", 1, -300)
    @test_contact_ids << result['data']['contactId']
    id = result['data']['contactId']
    key = result['data']['confirmationKey']

    result = @contact.confirm(id, key)
    result['status'].should == 'ok'
  end

  it 'should be able to activate a contact' do
    result = @contact.activate(@test_contact_ids.first)
    result['status'].should == 'ok'
  end

  it 'should be able to deactivate a contact' do
    result = @contact.deactivate(@test_contact_ids.first)
    result['status'].should == 'ok'
  end

  it 'should get a list of contact groups' do
    result = @contact.groups
    result.class.should == Array
  end

  it 'should get a list of contacts' do
    result = @contact.contacts
    result.class.should == Array
  end

  it 'should get recent alerts' do
    result = @contact.recent_alerts
    result['status'].should == 'ok'
  end

end