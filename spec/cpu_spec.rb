require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe CPUMonitors do
  before :each do
    agents = Agents.new(use_production: true)
    @agent_key = agents.agents.first['key']
    @agent_id = agents.agents.first['id']
    @mon = self.described_class.new(use_production: true)
    temp = temp_name
    @mon_ids = []
  end

  after :each do
    @mon.delete(@mon_ids.join(','))
  end

  def add_monitor
    temp = temp_name
    id = @mon.add(@agent_key, temp, temp, idleMin: 1, ioWaitMax: 1,
                  kernelMax: 1, niceMax: 1, usedMax: 1)['data']['testId']
    @mon_ids << id
    id
  end

  it 'should add a CPU monitor' do
    temp = temp_name
    result = @mon.add(@agent_key, temp, temp, idleMin: 1, 
                      ioWaitMax: 1, kernelMax: 1, niceMax: 1, 
                      usedMax: 1)
    result.status.should == 'ok'
    @mon_ids << result['data']['testId'] if result.is_ok?
  end

  it 'should edit a CPU monitor' do
    temp = temp_name
    id = add_monitor
    result = @mon.edit(id, temp, temp, idleMin: 2, 
                       ioWaitMax: 2, kernelMax: 2, niceMax: 2, 
                       usedMax: 2)
    result.status.should == 'ok'
  end

  it 'should delete a CPU monitor' do
    id = add_monitor
    @mon.delete(id)
  end

  it 'should list CPU monitors' do
    result = @mon.monitors(@agent_id)
    result.class.should == Array
  end

  it 'should get CPU Monitor info' do
    id = add_monitor
    result = @mon.info(id)
    result['id'].should == id
  end

  it 'should get results for a CPU monitor' do
    t = Time.now
    id = add_monitor
    result = @mon.results(id, t.year, t.month, t.day)
    result.class.should == Array
  end
end