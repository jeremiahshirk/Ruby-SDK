class TransactionMonitors < MonitisClient
  
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

  def monitors(options={})
    get('transactionTests', options)
  end

  def info(monitor_id)
    get('transactionTestInfo', monitorId: monitor_id)
  end

  def results(monitor_id, year, month, day, options={})
    args = {monitorId: monitor_id, year: year, month: month, day: day}
           .merge(options)
    get('transactionTestResult', args)
  end

  def step_results(result_id, year, month, day)
    args = {resultId: result_id, year: year, month: month, day: day}
    get('transactionStepResult', args)
  end

  def step_capture(monitor_id, result_id)
    args = {monitorId: monitor_id, resultId: result_id}
    get('transactionStepCapture', args)
  end

  def step_net(result_id, year, month, day)
    args = {resultId: result_id, year: year, month: month, day: day}
    get('transactionStepNet', args)
  end

  def locations()
    get('transactionLocations')
  end

  def snapshot(options={})
    get('transactionSnapshot', options)
  end

end