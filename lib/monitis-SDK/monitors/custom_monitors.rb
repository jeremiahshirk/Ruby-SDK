# == Manage custom monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class CustomMonitors < MonitisClient

  # Create a new custom monitor manager
  def initialize(options={})
    options[:use_custom_monitor] = true
    super(options)
  end

  # Add a new custom monitor
  #
  # === Required arguments
  # * result_params - parameters of the monitor
  # * name - name of the custom monitor
  # * tag - tag of the custom monitor
  #
  # === Optional arguments
  # * additionalResultParams - additional result parameters of the monitor
  # * agentName - name of the custom user agent
  # * agentId - id of the custom user agent
  # * type - custom string that represents monitor type
  def add(result_params, name, tag, options={})
    args = {resultParams: result_params, name: name, tag: tag}.merge(options)
    post('addMonitor', args)
  end

  # Edit an existing custom monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to edit
  #
  # === Optional arguments
  # * name - name of the custom monitor
  # * tag - tag of the custom monitor
  # * monitorParams - parameters of the monitor
  # * additionalResultParams - additional result parameters of the monitor
  # * resultParams - parameters of the monitor
  def edit(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    post('editMonitor', args)
  end

  # Delete an existing custom monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to delete
  def delete(monitor_id, options={})
    args={monitorId: monitor_id}.merge(options)
    post('deleteMonitor', args)
  end

  # Add results to a custom monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor
  # * checktime - time of the check (number of milliseconds since
  #   January 1, 1970, 00:00:00 GMT)
  # * results - result(s) of the monitor
  #
  # === Optional arguments
  # * additionalResults - additional result(s) of the monitor as a JSON array
  def add_result(monitor_id, checktime, results, options={})
    args = {monitorId: monitor_id, checktime: checktime, 
            results: results}.merge(options)
    post('addResult', args)
  end

  # Add additional results for the monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor
  # * checktime - time of the check (number of milliseconds since
  #   January 1, 1970, 00:00:00 GMT)
  # * results - result(s) of the monitor
  def add_additional_results(monitor_id, checktime, results, options={})
    args = {monitorId: monitor_id, checktime: checktime,
            results: results}.merge(options)
    post('addAdditionalResults', args)
  end

  # Get existing custom monitors
  #
  # === Optional arguments
  # * tag - tag to get monitors for
  # * type - type of the monitor
  # * name - name of the monitor
  # * agentId - ID of the agent
  def monitors(options={})
    get('getMonitors', options)
  end

  # Get info for a custom monitor
  #
  # === Required arguments
  # * monitor_id - ID of monitor to get info for
  #
  # === Optional arguments
  # * excludeHidden - if true hidden MonitorParams won't
  #   be included in response.  Default value is false
  def info(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    get('getMonitorInfo', args)
  end

  # Get results for a monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to get result for
  # * year - year that results should be retrieved for
  # * month - month that results should be retrieved for
  # * day - day that results should be retrieved for
  #
  # === Optional arguments
  # * timezone - offset relative to GMT, used to show results
  #   in the timezone of the user
  def results(monitor_id, year, month, day, options={})
    args = {monitorId: monitor_id, year: year, month: month,
            day: day}.merge(options)
    get('getMonitorResults', args)
  end

  # Get results of the specified Custom monitor for the specified period
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to get result for
  # * from - starting date time (number of milliseconds since
  #   January 1, 1970, 00:00:00 GMT) to retrive results
  # * to - ending date time
  #
  # === Optional arguments
  # * interval - interval in minutes. If interval is not specified all
  #   results will be retreived. If interval is specified one average
  #   result for each interval will be retreived.
  # * timezone - offset in minutes relative to GMT,
  #   used to show results in the timezone of the user
  def report(monitor_id, from, to, options={})
    args = {monitorId: monitor_id, dateFrom: from, dateTo: to}.merge(options)
    get('getReport', args)
  end

  # Get additional results from the specified monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to get additional results for
  #
  # === Optional arguments
  # * checktime - check time to get additional results for
  def additional_results(monitor_id, options={})
    args = {monitorId: monitor_id, checktime: checktime}.merge(options)
    get('getAdditionalResults', args)
  end
 
end