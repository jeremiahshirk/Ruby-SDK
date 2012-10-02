class FullPageLoadMonitors < MonitisClient

  def add(name, tag, location_ids, check_interval, url, timeout, options={})
    check_interval = check_interval.join(',') if check_interval.class == Array
    location_ids = location_ids.join(',') if location_ids.class == Array
    args = {name: name, tag: tag, locationIds: location_ids,
            checkInterval: check_interval, url: url,
            timeout:timeout}.merge(options)
    post('addFullPageLoadMonitor', args)
  end

  def edit(monitor_id, name, tag, location_ids, check_interval, url, timeout, options={})
    check_interval = check_interval.join(',') if check_interval.class == Array
    location_ids = location_ids.join(',') if location_ids.class == Array
    args = {monitorId: monitor_id, name: name, tag: tag,
            locationIds: location_ids, checkInterval: check_interval,
            url:url, timeout:timeout}.merge(options)
    post('editFullPageLoadMonitor', args)
  end

  def delete(monitor_ids, options={})
    monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
    args = {monitorId: monitor_ids}.merge(options)
    post('deleteFullPageLoadMonitor', args)
  end

  def activate(monitor_ids, options={})
    # pass in nil for monitor_ids to use tag in options
    if monitor_ids
      monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
      args = {monitorIds: monitor_ids}.merge(options)
    else
      args = options
    end
    post('activateFullPageLoadMonitor', args)
  end

  def suspend(monitor_ids, options={})
    # pass in nil for monitor_ids to use tag in options
    if monitor_ids
      monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
      args = {monitorIds: monitor_ids}.merge(options)
    else
      args = options
    end
    post('suspendFullPageLoadMonitor', args)
  end

  def info(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    get('fullPageLoadTestInfo', args)
  end

  def results(monitor_id, year, month, day, options={})
    args = {monitorId: monitor_id, year: year, month: month,
            day: day}.merge(options)
    get('fullPageLoadTestResult', args)
  end

  def monitors(options={})
    get('fullPageLoadTests', options)
  end

  def locations(options={})
    get('fullPageLoadLocations', options)
  end

  def snapshot(options={})
    get('fullPageLoadSnapshot', options)
  end

end