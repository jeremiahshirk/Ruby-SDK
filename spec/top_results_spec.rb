require 'monitis-SDK'

describe TopResults do
  before :each do
    @top = self.described_class.new(use_production: true)
  end

  it 'should get top results for external monitors' do
    @top.external.has_key?('tests').should == true
  end

  it 'should get top results for CPU monitors' do
    @top.cpu.has_key?('tests').should == true
  end

  it 'should get top results for drive monitors' do
    @top.drive.has_key?('tests').should == true
  end

  it 'should get top results for memory monitors' do
    @top.memory.has_key?('tests').should == true
  end

  it 'should get top results for load1 monitors' do
    @top.load1.has_key?('tests').should == true
  end

  it 'should get top results for load5 monitors' do
    @top.load5.has_key?('tests').should == true
  end

  it 'should get top results for load15 monitors' do
    @top.load15.has_key?('tests').should == true
  end

  it 'should get top results for Internal HTTP monitors' do
    @top.http.has_key?('tests').should == true
  end

  it 'should get top results for Internal Ping monitors' do
    @top.ping.has_key?('tests').should == true
  end

  it 'should get top results for transaction monitors' do
    @top.transaction.has_key?('tests').should == true
  end

  it 'should get top results for full page load monitors' do
    @top.fullpage.has_key?('tests').should == true
  end

  it 'should get top results for process monitors by CPU usage' do
    @top.process_cpu.has_key?('tests').should == true
  end

  it 'should get top results for process monitors by memory usage' do
    @top.process_memory.has_key?('tests').should == true
  end

  it 'should get top results for process monitors by virtual memory usage' do
    @top.process_virt_memory.has_key?('tests').should == true
  end


end