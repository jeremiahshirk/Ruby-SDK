class CustomMonitors < MonitisClient
  
  def initialize(options={})
    options[:use_custom_monitor] = true
    super(options)
  end

  def add(result_params, name, tag, options={})
    args = {resultParams: result_params, name: name, tag: tag}.merge(options)
    addMonitor(args)
  end

  def edit(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    editMonitor(args)
  end

  def delete(monitor_id, options={})
    args={monitorId: monitor_id}.merge(options)
    deleteMonitor(args)
  end

  def add_result(monitor_id, checktime, results, options={})
    args = {monitorId: monitor_id, checktime: checktime, 
            results: results}.merge(options)
    addResult(args)
  end

  def add_additional_results(monitor_id, checktime, results, options={})
    args = {monitorId: monitor_id, checktime: checktime,
            results: results}.merge(options)
    addAdditionalResults(args)
  end

  def monitors()
    getMonitors
  end

  def info(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    getMonitorInfo(args)
  end

  def results(monitor_id, year, month, day, options={})
    args = {monitorId: monitor_id, year: year, month: month,
            day: day}.merge(options)
    getMonitorResults(args)
  end

  def report(monitor_id, from, to, options={})
    args = {monitorId: monitor_id, dateFrom: from, dateTo: to}.merge(options)
    getReport(args)
  end

  def additional_results(monitor_id, checktime, options={})
    args = {monitorId: monitor_id, checktime: checktime}.merge(options)
    getAdditionalResults(args)
  end
 
end