require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'
require 'time'

describe Agents do
  before :each do
    @agents = Agents.new(use_production: true)
    @agent_id = @agents.agents.first['id']
  end

  it 'should get a list of all agents' do
    result = @agents.agents
    result.class.should == Array
  end

  it 'should get info for an agent' do
    result = @agents.info(@agent_id)
    result['id'].should == @agent_id
  end

  it 'should get a snapshot for all agents matching a platform' do
    platform = @agents.agents.first['platform']
    result = @agents.snapshot(platform: platform)
    result.has_key?('agents').should == true
  end

  it 'should raise an error if there are no args to snapshot' do
    expect { @agents.snapshot }.to raise_exception
  end

  it 'should get a snapshot for a specific agent' do
    key = @agents.agents.first['key']
    result = @agents.snapshot(agentKey: key)
    result['id'].should == @agent_id
  end

  it 'should delete an agent' do
    # we can't create an agent, so try to delete one that won't exist
    result = @agents.delete([0,1])
    result.status.should == 'invalid agent'
  end

  it 'should delete an agent by Hash' do
    # we can't create an agent, so try to delete one that won't exist
    result = @agents.delete(agentIds: '0,1')
    result.status.should == 'invalid agent'
  end

  it 'should download an agent' do
    result = @agents.download('linux32')
    result.code.should == 200
  end
end