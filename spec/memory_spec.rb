require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe MemoryMonitors do
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
    id = @mon.add(@agent_key, temp, temp, freeLimit: 1, freeSwapLimit: 1,
                  bufferedLimit: 1, cachedLimit: 1, platform: 'LINUX')['data']['testId']
    @mon_ids << id
    id
  end

  it 'should add a Memory monitor' do
    temp = temp_name
    result = @mon.add(@agent_key, temp, temp, freeLimit: 1,
                      freeSwapLimit: 1, bufferedLimit: 1,
                      cachedLimit: 1, platform: 'LINUX')
    result.status.should == 'ok'
    @mon_ids << result['data']['testId'] if result.is_ok?
  end

  it 'should edit a Memory monitor' do
    temp = temp_name
    id = add_monitor
    result = @mon.edit(id, temp, temp, freeLimit: 1, freeSwapLimit: 1,
                       bufferedLimit: 1, cachedLimit: 1, platform: 'LINUX')
    result.status.should == 'ok'
  end

  it 'should delete a Memory monitor' do
    id = add_monitor
    @mon.delete(id)
  end

  it 'should list Memory monitors' do
    result = @mon.monitors(@agent_id)
    result.class.should == Array
  end

  it 'should get Memory Monitor info' do
    id = add_monitor
    result = @mon.info(id)
    result['id'].should == id
  end

  it 'should get results for a Memory monitor' do
    t = Time.now
    id = add_monitor
    result = @mon.results(id, t.year, t.month, t.day)
    result.class.should == Array
  end
end