require 'monitis-SDK'

describe Base do
  before :each do
    @prod = Contact.new(use_production: true)
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

end