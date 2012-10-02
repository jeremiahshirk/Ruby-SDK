require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe VisitorTrackerMonitors do
  before :each do
    @mon = self.described_class.new(use_production: true)
  end

  it 'should get results for a visitor tracker' do
    t = Time.now
    site_id = @mon.sites.first
    result = @mon.results(site_id, t.year, t.month, t.day)
    result.class.should == Hash
    result.has_key?('trend').should == true
  end

  it 'should get info for a visitor tracker' do
    # @mon.debug = true
    site_id = @mon.sites.first
    result = @mon.info(site_id)
    # result['sid'].should == site_id
    result.class.should == Hash
  end

  it 'should get the visitor trackers' do
    result = @mon.monitors
    result.class.should == Array
  end

end