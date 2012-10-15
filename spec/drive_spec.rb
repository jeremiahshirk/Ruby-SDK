require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe DriveMonitors do
  before :each do
    agents = Agents.new(use_production: true).agents
    @agent_key = agents.first['key']
    @agent_id = agents.first['id']
    @mon = self.described_class.new(use_production: true)
    # temp = temp_name
    @mon_ids = []
  end

  after :each do
    if @mon_ids.length > 0
      @mon.delete(@mon_ids.join(','))
    end
  end

  def add_monitor
    temp = temp_name
    id = @mon.add(@agent_key, temp, temp,
                  freeLimit: 2, driveLetter: 'Z')['data']['testId']
    @mon_ids << id
    id
  end

  it 'should add a Drive monitor' do
    temp = temp_name
    result = @mon.add(@agent_key, temp, temp, freeLimit: 1, driveLetter: 'C')
    result.status.should == 'ok'
    @mon_ids << result['data']['testId'] if result.is_ok?
  end

  it 'should edit a Drive monitor' do
    temp = temp_name
    id = add_monitor
    result = @mon.edit(id, temp, temp,
                       freeLimit: 1, driveLetter: 'C')
    result.status.should == 'ok'
  end

  it 'should delete a Drive monitor' do
    id = add_monitor
    @mon.delete(id)
  end

  it 'should list Drive monitors' do
    result = @mon.monitors(@agent_id)
    result.class.should == Array
  end

  it 'should get Drive Monitor info' do
    id = add_monitor
    result = @mon.info(id)
    result['id'].should == id
  end

  it 'should get results for a Drive monitor' do
    t = Time.now
    id = add_monitor
    result = @mon.results(id, t.year, t.month, t.day)
    result.class.should == Array
  end
end