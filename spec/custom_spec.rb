require 'monitis-SDK'
require 'securerandom'
require 'time'

def temp_name()
  "test_#{SecureRandom.hex 4}"
end

def checktime()
  Time::now.strftime('%s000')
end

describe CustomMonitors do
  before :each do
    @custom = CustomMonitors.new
    @test_id = @custom.add('t:T:s:4', temp_name, temp_name,
                           additionalResultParams: 'ta:T:s:4')['data']
    @test_custom_ids = [@test_id]
  end

  after :each do
    @test_custom_ids.each { |id| @custom.delete(id)}
  end

  it 'should add a custom monitor' do
    result = @custom.add('t:T:s:4', temp_name, temp_name)
    @test_custom_ids << result['data']
    result['status'].should == 'ok'
  end

  it 'should delete a custom monitor' do
    result = @custom.delete(@test_id)
    result['status'].should == 'ok'
  end

  it 'should edit a custom monitor' do
    id = @custom.add('t:T:s:4', temp_name, temp_name)['data']
    @test_custom_ids << id
    sleep 3
    result = @custom.edit(id, name: temp_name)
    result['status'].should == 'ok'
  end

  it 'should add results' do
    result = @custom.add_result(@test_id, checktime, 't:1')
    result['status'].should == 'ok'
  end

  it 'should add additional results' do
    result = @custom.add_additional_results(@test_id, checktime, '[{"ta":1}]')
    result['status'].should == 'ok'
  end

  it 'should get custom monitors' do
    result = @custom.monitors
    result.class.should == Array
  end

  it 'should get monitor info' do
    result = @custom.info(@test_id)
    result['id'].should == @test_id.to_s
  end

  it 'should get monitor results' do
    t = Time::now
    result = @custom.results(@test_id, t.year, t.month, t.day)
    result.class.should == Array
  end

  it 'should get a custom monitor report' do
    result = @custom.report(@test_id, checktime.to_i - 86400000, checktime)
    result.class.should == Array
  end

  it 'should get additional results' do
    result = @custom.additional_results(@test_id, checktime: checktime)
    result.class.should == Array
  end
end

