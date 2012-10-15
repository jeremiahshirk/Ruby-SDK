require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe CloudInstances do
  before :each do
    @mon = self.described_class.new(use_production: true)
  end

  def test_instance
  	instances = @mon.instances
  	type = instances.keep_if {|k,v| v.length > 0}.keys.first
  	[type, instances[type].first]
  end


  it 'should get the cloud instances' do
  	result = @mon.instances
  	['gogrid', 'ec2', 'rackspace'].each do |x|
	  	result.has_key?(x).should == true
	  end
  end

  it 'should get the info for a cloud instance' do
  	type, instance = test_instance
  	result = @mon.info(type, instance['id'])
  	result['id'].should == instance['id']
  end

end