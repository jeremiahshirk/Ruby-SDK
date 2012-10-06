# == Implement methods to manage full page load monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class FullPageLoadMonitors < MonitisClient

  # Add a full page load monitor
  #
  # === Required arguments
  # * name - the name of the monitor
  # * tag - tag for the monitor
  # * location_ids - IDs for locations for the monitor
  # * check_interval - comma separated values of check intervals(in minutes)
  #   for locations. Order must be the same as in locationIds parameter
  # * url - URL for the monitor
  # * timeout - test timeout in ms
  #
  # === Optional arguments
  # * uptimeSLA - minimum allowed uptime (%)
  # * responseSLA - maximum allowed response time in seconds
  def add(name, tag, location_ids, check_interval, url, timeout, options={})
    check_interval = check_interval.join(',') if check_interval.class == Array
    location_ids = location_ids.join(',') if location_ids.class == Array
    args = {name: name, tag: tag, locationIds: location_ids,
            checkInterval: check_interval, url: url,
            timeout:timeout}.merge(options)
    post('addFullPageLoadMonitor', args)
  end

  # Edit an existing monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to edit
  # * name - the name of the monitor
  # * tag - tag for the monitor
  # * location_ids - IDs for locations for the monitor
  # * check_interval - comma separated values of check intervals(in minutes)
  #   for locations. Order must be the same as in locationIds parameter
  # * url - URL for the monitor
  # * timeout - test timeout in ms
  def edit(monitor_id, name, tag, location_ids, check_interval, url, timeout, options={})
    check_interval = check_interval.join(',') if check_interval.class == Array
    location_ids = location_ids.join(',') if location_ids.class == Array
    args = {monitorId: monitor_id, name: name, tag: tag,
            locationIds: location_ids, checkInterval: check_interval,
            url:url, timeout:timeout}.merge(options)
    post('editFullPageLoadMonitor', args)
  end

  # Delete a full page load monitor
  #
  # === Required arguments
  # * monitor_ids - comma separated ids of monitors to delete
  def delete(monitor_ids, options={})
    monitor_ids = monitor_ids.join(',') if monitor_ids.class == Array
    args = {monitorId: monitor_ids}.merge(options)
    post('deleteFullPageLoadMonitor', args)
  end

  # Activate full page load monitors
  #
  # === Required arguments
  # * monitor_ids - comma separated list of monitors to activate
  #
  # === Optional arguments
  # * tags - monitors with this tag will be activated
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

  # Suspend full page load monitors
  #
  # === Required arguments
  # * monitor_ids - comma separated list of monitors to suspend
  #
  # === Optional arguments
  # * tags - monitors with this tag will be suspended
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

  # Get info for a full page load monitor
  #
  # === Required arguments
  # * monitor_id - ID of the monitor to get information for
  def info(monitor_id, options={})
    args = {monitorId: monitor_id}.merge(options)
    get('fullPageLoadTestInfo', args)
  end

  # Get results for a specified full page load monitor
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
    args = {monitorId: monitor_id, year: year, month: month,
            day: day}.merge(options)
    get('fullPageLoadTestResult', args)
  end

  # Get a list of full page load monitors
  def monitors(options={})
    get('fullPageLoadTests', options)
  end

  # Get locations for the specified monitor
  def locations(options={})
    get('fullPageLoadLocations', options)
  end

  # Get snapshots for all full page load monitors
  def snapshot(options={})
    get('fullPageLoadSnapshot', options)
  end

end