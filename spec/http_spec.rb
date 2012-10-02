require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe HTTPMonitors do
  before :each do
    agents = Agents.new(use_production: true)
    @agent_key = agents.agents.first['key']
    @agent_id = agents.agents.first['id']
    @mon = self.described_class.new(use_production: true)
    temp = temp_name
    @mon_ids = []
  end

  after :each do
    @mon.deleteInternalMonitors(testIds: @mon_ids.join(','), type:4)
  end

  def add_monitor
    temp = temp_name
    id = @mon.add(@agent_id, temp, temp, url: 'mon.itor.us', timeout: 30000,
                  redirect: 1,
                  postData: 'apiKey%3Dkldfjeur84dfh%26user%3Dmon_user',
                  loadFull: 1, httpMethod: 1, contentMatchFlag: 1,
                  contentMatchString: 'OK', overSSL: 1, userAuth: 'monUser',
                  passAuth: 'monPass11')['data']['testId']
    @mon_ids << id
    id
  end

  it 'should add a HTTP monitor' do
    temp = temp_name
    result = @mon.add(@agent_id, temp, temp, url: 'mon.itor.us', 
                      timeout: 30000, redirect: 1,
                      postData: 'apiKey%3Dkldfjeur84dfh%26user%3Dmon_user',
                      loadFull: 1, httpMethod: 1, contentMatchFlag: 1,
                      contentMatchString: 'OK', overSSL: 1,
                      userAuth: 'monUser', passAuth: 'monPass11')
    result.status.should == 'ok'
    @mon_ids << result['data']['testId'] if result.is_ok?
  end

  it 'should edit a HTTP monitor' do
    temp = temp_name
    id = add_monitor
    result = @mon.edit(id, temp, temp, timeout: 25000, httpMethod: 1,
                       urlParams: 'action%3Daddtest%26id%3D568',
                       postData: 'apiKey%3Dkldfjeur84dfh%26user%3Dmon_user',
                       contentMatchString: 'ok', userAuth: 'monUser',
                       passAuth: 'monPass')
    result.status.should == 'ok'
  end

  it 'should delete a HTTP monitor' do
    id = add_monitor
    @mon.delete(id)
  end

  it 'should list HTTP monitors' do
    result = @mon.monitors(@agent_id)
    result.class.should == Array
  end

  it 'should get HTTP Monitor info' do
    id = add_monitor
    result = @mon.info(id)
    result['id'].should == id
  end

  it 'should get results for a HTTP monitor' do
    t = Time.now
    id = add_monitor
    result = @mon.results(id, t.year, t.month, t.day)
    result.has_key?('data').should == true
  end
end