require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe ExternalMonitors do
  before :each do
    @ext = ExternalMonitors.new(use_production: true)
    @test_tag = temp_name
    result = @ext.add('ping', @test_tag, "#{temp_name}.wordpress.com",
                      5, '1,2', @test_tag)
    @ext_ids = [result['data']['testId']]
  end

  after :each do
    @ext.delete(@ext_ids) unless @ext_ids.empty?
  end

  it 'should add an external monitor' do
    result = @ext.add('ping', temp_name, "#{temp_name}.wordpress.com", 5, 
                      '1,2', temp_name)
    result.is_ok?.should == true
    @ext_ids << result['data']['testId']
  end

  it 'should edit an external monitor' do
    result = @ext.edit(@ext_ids.first, temp_name, 
                       "#{temp_name}.wordpress.com", '1-5', 5000, temp_name)

    result.is_ok?.should == true
  end

  it 'should delete an external monitor' do
    id = @ext_ids.first
    result = @ext.delete(id)
    result.is_ok?.should == true
    @ext_ids.delete(id)
  end

  it 'should suspend an external monitor' do
    result = @ext.suspend(@ext_ids.first)
    result.is_ok?.should == true
  end

  it 'should activate an external monitor' do
    result = @ext.activate(@ext_ids.first)
    result.is_ok?.should == true
  end

  it 'should suspend an external monitor by Hash' do
    result = @ext.suspend(monitorIds: @ext_ids.first)
    result.is_ok?.should == true
  end

  it 'should activate an external monitor by Hash' do
    result = @ext.activate(monitorIds: @ext_ids.first)
    result.is_ok?.should == true
  end

  it 'should suspend an external monitor by Array' do
    result = @ext.suspend([@ext_ids.first])
    result.is_ok?.should == true
  end

  it 'should activate an external monitor by Array' do
    result = @ext.activate([@ext_ids.first])
    result.is_ok?.should == true
  end

  it 'should get a list of locations' do
    result = @ext.locations
    result.class.should == Array
  end

  it 'should get a list of monitors' do
    result = @ext.monitors
    result['testList'].class.should == Array
    result['testList'].length > 0
  end

  it 'should get a list of monitors by tag' do
    result = @ext.monitors(@test_tag)
    result['testList'].first['name'].should == @test_tag
    result['testList'].length > 0
  end

  it 'should get the info for a monitor' do
    result = @ext.info(@ext_ids.first)
    result['tag'].should == @test_tag
  end

  it 'should get the resultd for a monitor' do
    t = Time::now
    result = @ext.results(@ext_ids.first, t.day, t.month, t.year)
    result.class.should == Array
  end

  it 'should get a snapshot for all monitors' do
    result = @ext.snapshot
    result.class.should == Array
  end
  
  it 'should get the tags for external monitors' do
    result = @ext.tags
    result.has_key?('tags').should == true
  end
end
