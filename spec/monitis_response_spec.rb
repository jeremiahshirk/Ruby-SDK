require 'spec_helper'
require 'monitis-SDK'

describe MonitisResponse do
  before :each do
  	@ok = MonitisResponse.new
  	@ok['status'] = 'ok'
  	@error = MonitisResponse.new
  	@error['error'] = 'Message'
  end

  after :each do
  end

  it 'should get the status' do
  	@ok.status.should == 'ok'
  end

  it 'should get the error' do
  	@error.error.should == 'Message'
  end

end