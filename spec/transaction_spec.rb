require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

describe TransactionMonitors do
  before :each do
    # agents = Agents.new(use_production: true)
    # @agent_key = agents.agents.first['key']
    # @agent_id = agents.agents.first['id']
    @mon = self.described_class.new(use_production: true)
    # temp = temp_name
    # @mon_ids = []
  end

  after :each do
    # if @mon_ids.length > 0
    #   @mon.deleteInternalMonitors(testIds: @mon_ids.join(','), type:5) 
    # end
  end

  it 'should suspend a transaction monitor' do
    result = @mon.suspend(@mon.monitors.first['id'])
    result.status.should == 'ok'
  end

  it 'should activate a transaction monitor' do
    result = @mon.activate(@mon.monitors.first['id'])
    result.status.should == 'ok'
  end

  it 'should get a list of transaction monitors' do
    result = @mon.monitors
    result.class.should == Array
    result.length.should > 0
  end

  it 'should get info for a transaction monitor' do
    result = @mon.info(@mon.monitors.first['id'])
    result.class.should == Hash
  end

  ## can't test unless we can create some results, but no API for that
  # it 'should get results for a transaction monitor' do
  #   t = Time.now
  #   (year, month, day) = t.year, t.month, t.day
  #   result = @mon.results(@mon.monitors.first['id'], year, month, day)
  #   result.class.should == Array
  # end

  it 'should get step results for a transaction monitor' do
    t = Time.now
    (year, month, day) = t.year, t.month, t.day
    result = @mon.step_results(@mon.monitors.first['id'], year, month, day)
    result.class.should == Array
  end

  # # can't test unless we can create results, but no API for that
  # it 'should get the step capture or a transaction monitor' do
  # end

  # # can't test unless we can create results, but no API for that
  # it 'should get step net for a transaction monitor' do
  # end

  it 'should get transaction monitor locations' do
    result = @mon.locations
    result.class.should == Array
  end

  it 'should get transaction monitor snapshots' do
    result = @mon.snapshot
    result.class.should == Array
  end

end