require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

def checktime()
  Time::now.strftime('%s000')
end

describe CustomAgent do
  before :each do
    @agent = CustomAgent.new(use_production: true)
    agent = @agent.add(temp_name)['data']
    @temp_agent_ids = [agent]
    job = @agent.add_job(agent, 'custom', 3, 'x:ms')['data']
    @temp_job_ids = [job]
  end

  after :each do
    @agent.delete(@temp_agent_ids)
  end

  it 'should add an agent' do
    result = @agent.add(temp_name)
    result['status'].should == 'ok'
    @temp_agent_ids << result['data']
  end

  it 'should add a job' do
    result = @agent.add_job(@temp_agent_ids.first, 'custom', 3, 'x:ms')
    result['status'].should == 'ok'
  end

  it 'should edit an agent' do
    result = @agent.edit(@temp_agent_ids.first, temp_name)
    result['status'].should == 'ok'
  end

  it 'should edit a job' do
    result = @agent.edit_job(@temp_job_ids.first, interval: 5)
    result['status'].should == 'ok'
  end

  it 'should delete an agent' do
    result = @agent.delete(@temp_agent_ids)
    result['status'].should == 'ok'
  end

  it 'should delete a job' do
    result = @agent.delete_job(@temp_job_ids)
    result['status'].should == 'ok'
  end

  it 'should get the agents' do
    result = @agent.agents
    result.first.keys.include?('name').should == true
  end

  it 'should get the jobs' do
    result = @agent.jobs(@temp_agent_ids.first)
    result.class.should == Array
  end

end