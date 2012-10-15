require 'spec_helper'
require 'monitis-SDK'
require 'securerandom'

describe Layout do
  before :each do
    @layout = Layout.new
    @test_page_ids = [@layout.add_page(temp_name)['data']['pageId']]
  end

  after :each do
    @test_page_ids.each { |page_id| @layout.delete_page(page_id)}
  end

  it 'should be able to add a page' do
    result = @layout.add_page(temp_name)
    @test_page_ids << result['data']['pageId']
    result['status'].should == 'ok'
  end

  it 'should be able to add a page with columns specified' do
    result = @layout.add_page(temp_name, columnCount: 8)
    @test_page_ids << result['data']['pageId']
    result['status'].should == 'ok'
  end

  it 'should be able to add a module to a page' do
    custom = CustomMonitors.new(use_custom_monitor: true)
    custom_id = custom.monitors.first['id']
    result = @layout.add_page_module("CustomMonitor", @test_page_ids.first,
                                     1, 1, custom_id)
    result['status'].should == 'ok'
  end

  it 'should be able to delete a page' do
    result = @layout.delete_page(@test_page_ids.first)
    result['status'].should == 'ok'
  end

  it 'should be able to delete a module from a page' do
    custom = CustomMonitors.new(use_custom_monitor: true)
    custom_id = custom.monitors.first['id']
    id = @layout.add_page_module("CustomMonitor", @test_page_ids.first,
                                     1, 1, custom_id)['data']['pageModuleId']
    result = @layout.delete_page_module(id)
    result['status'].should == 'ok'
  end

  it 'should be able to get page modules' do
    name = @layout.pages.first.fetch('title')
    result = @layout.page_modules(name)
    result.class.should == Array
  end

  it 'should be able to get all pages' do
    result = @layout.pages
    result.find {|x| x['id'] == @test_page_ids.first}.should_not == nil
  end

end