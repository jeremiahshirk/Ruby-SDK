# == Implement methods to manage transaction monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class TransactionMonitors < MonitisClient

  # Suspend transaction monitors
  #
  # === Required arguments
  # * monitor_ids - comma separated list of monitors to suspend
  #
  # === Optional arguments
  # * tags - transaction monitors with this tag will be suspended
  def suspend(monitor_ids, options={})
    # pass in nil for monitor_ids to use tag in options
    if monitor_ids
      monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
      args = {monitorIds: monitor_ids}.merge(options)
    else
      args = options
    end
    post('suspendTransactionMonitor', args)
  end

  # Activate transaction monitors
  #
  # === Required arguments
  # * monitor_ids - comma separated list of monitors to activate
  #
  # === Optional arguments
  # * tags - transaction monitors with this tag will be activated
  def activate(monitor_ids, options={})
    # pass in nil for monitor_ids to use tag in options
    if monitor_ids
      monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
      args = {monitorIds: monitor_ids}.merge(options)
    else
      args = options
    end
    post('activateTransactionMonitor', args)
  end

  # Get a list of transaction monitors
  #
  # === Optional arguments
  # * type - 0 to get transaction monitors, 1 to get full page load monitors.
  #   default value is 0
  def monitors(options={})
    get('transactionTests', options)
  end

  # Get info for a transaction monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to get information for
  #
  # === Optional arguments
  def info(monitor_id)
    get('transactionTestInfo', monitorId: monitor_id)
  end

  # Get results for a specified transaction or full page load monitor
  #
  # === Required arguments
  # * monitor_id
  # * year
  # * month
  # * day
  #
  # === Optional arguments
  # * timezone - offset relative to GMT, in minutes, 
  #   used to show results in the timezone of the user
  # * locationIds - comma separated ids of locations for which results should
  #    be retrieved
  def results(monitor_id, year, month, day, options={})
    args = {monitorId: monitor_id, year: year, month: month, day: day}
           .merge(options)
    get('transactionTestResult', args)
  end

  # Get step results for the specified transaction monitor result
  #
  # === Required arguments
  # * result_id
  # * year
  # * month
  # * day
  def step_results(result_id, year, month, day)
    args = {resultId: result_id, year: year, month: month, day: day}
    get('transactionStepResult', args)
  end

  # Get step capture for the specified transaction monitor and result
  #
  # === Required arguments
  # * monitor_id
  # * result_id
  def step_capture(monitor_id, result_id)
    args = {monitorId: monitor_id, resultId: result_id}
    get('transactionStepCapture', args)
  end

  # Get step net for the specified result
  #
  # === Required arguments
  # * result_id
  # * year
  # * month
  # * day
  def step_net(result_id, year, month, day)
    args = {resultId: result_id, year: year, month: month, day: day}
    get('transactionStepNet', args)
  end

  # Get locations for the specified transaction monitor
  def locations()
    get('transactionLocations')
  end

  # Get snapshots for all transaction monitors
  def snapshot(options={})
    get('transactionSnapshot', options)
  end

end