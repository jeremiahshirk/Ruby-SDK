require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe FullPageLoadMonitors do
  before :each do
    @mon = self.described_class.new(use_production: true)
    name = @tag = temp_name
    url = "http://#{temp_name}.wordpress.com"
    temp_mon = @mon.add(name, @tag, [1,2], [3,3], url, 5000)
    @mon_ids = [temp_mon['data']['testId']]
  end

  after :each do
    if @mon_ids.length > 0
      @mon.delete(@mon_ids)
    end
  end

  it 'should add a full page load monitor' do
    name = tag = temp_name
    url = "http://#{temp_name}.wordpress.com"
    result = @mon.add(name, tag, [1,2], [3,3], url, 5000)
    result.status.should == 'ok'
    @mon_ids << result['data']['testId']
  end

  it 'should edit a full page load monitor' do
    id = @mon_ids.first
    name = tag = temp_name
    url = "http://#{temp_name}.wordpress.com"
    result = @mon.edit(id, name, tag, [1,2], [3,3], url, 5000)
    result.status.should == 'ok'
  end

  it 'should delete a full page load monitor' do
    id = @mon_ids.shift
    result = @mon.delete id
    result.status.should == 'ok'
  end

  it 'should activate a full page load monitor' do
    result = @mon.activate @mon_ids.first
    result.status.should == 'ok'
  end

  it 'should suspend a full page load monitor' do
    result = @mon.suspend @mon_ids.first
    result.status.should == 'ok'
  end

  it 'should activate full page load monitors by tag' do
    result = @mon.activate(nil, tag: @tag)
    result.status.should == 'ok'
  end

  it 'should suspend full page load monitors by tag' do
    result = @mon.suspend(nil, tag: @tag)
    result.status.should == 'ok'
  end

  it 'should get info for a full page load monitor' do
    id = @mon_ids.first
    result = @mon.info id
    result['testId'].should == id
  end

  it 'should get results for a full page load monitor' do
    t = Time.now
    id = @mon_ids.first
    result = @mon.results(id, t.year, t.month, t.day)
    result.class.should == Array
  end

  it 'should get the full page load monitors' do
    result = @mon.monitors
    result.class.should == Array
  end

  it 'should get full page load monitor locations' do
    result = @mon.locations
    result.class.should == Array
  end

  it 'should get full page load monitor snapshots' do
    result = @mon.snapshot
    result.class.should == Array
  end
end

