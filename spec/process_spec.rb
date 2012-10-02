require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe ProcessMonitors do
  before :each do
    agents = Agents.new(use_production: true)
    @agent_key = agents.agents.first['key']
    @agent_id = agents.agents.first['id']
    @mon = self.described_class.new(use_production: true)
    temp = temp_name
    @mon_ids = []
  end

  after :each do
    @mon.deleteInternalMonitors(testIds: @mon_ids.join(','), type:1)
  end

  def add_monitor
    temp = temp_name
    id = @mon.add(@agent_key, temp, temp, cpuLimit: 60,
                      memoryLimit: 100, virtualMemoryLimit: 100,
                      processName: temp)['data']['testId']
    @mon_ids << id
    id
  end

  it 'should add a Process monitor' do
    temp = temp_name
    result = @mon.add(@agent_key, temp, temp, cpuLimit: 70,
                      memoryLimit: 100, virtualMemoryLimit: 100,
                      processName: temp)
    result.status.should == 'ok'
    @mon_ids << result['data']['testId'] if result.is_ok?
  end

  it 'should edit a Process monitor' do
    temp = temp_name
    id = add_monitor
    result = @mon.edit(id, temp, temp, cpuLimit: 50,
                      memoryLimit: 90, virtualMemoryLimit: 99)
    result.status.should == 'ok'
  end

  it 'should delete a Process monitor' do
    id = add_monitor
    @mon.delete(id)
  end

  it 'should list Process monitors' do
    result = @mon.monitors(@agent_id)
    result.class.should == Array
  end

  it 'should get Process Monitor info' do
    id = add_monitor
    result = @mon.info(id)
    result['id'].should == id
  end

  it 'should get results for a Process monitor' do
    t = Time.now
    id = add_monitor
    result = @mon.results(id, t.year, t.month, t.day)
    result.class.should == Array
  end
end