# == Manage external monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class ExternalMonitors < MonitisClient

  # Add an external monitor
  #
  # === Required arguments
  # * type - type of the test.  Supported test types are: "http", 
  #   "https", "ftp", "ping", "ssh", "dns", "mysql", "udp", "tcp", "sip", "smtp",
  #   "imap", "pop".
  # * name - name of the test
  # * url - URL of the test
  # * interval - check interval(min). Available values are 1, 3, 5, 10, 15,
  #   20, 30, 40, 60
  # * location_ids - comma separated ids of the locations to add test for
  # * tag - tag of the test
  #
  # === Optional arguments
  # * detailedTestType - specifies the request method. Used for HTTP and HTTPS.
  #   Possible values are 1 for GET, 2 for POST, 3 for PUT, 4 for DELETE.
  #   Default value is 1.
  # * timeout - test timeout in ms. Default value is 10000.
  #
  # See http://www.monitis.com/api/api.html#addExternalMonitor for
  # additional parameters
  #
  def add(type, name, url, interval, location_ids, tag, options={})
    args = {type: type, name: name, url: url, interval: interval,
            locationIds: location_ids, tag: tag}
            .merge(options)
    post('addExternalMonitor', args)
  end

  # Edit an external monitor
  #
  # === Required arguments
  # * test_id - ID of the test to edit
  # * name - name of the test
  # * url - URL of the test
  # * timeout - test timeout in ms
  # * location_ids - comma separated ids of the locations to add test for
  # * tag - tag of the test
  #
  # === Optional arguments
  # See http://www.monitis.com/api/api.html#editExternalMonitor for
  # additional parameters
  def edit(test_id, name, url, location_ids, timeout, tag, options={})
    args = {testId: test_id, name: name, url: url, locationIds: location_ids,
            timeout: timeout, tag: tag}.merge(options)
    post('editExternalMonitor', args)
  end

  # Delete an external monitor
  #
  # === Required arguments
  # * test_ids - comma separated IDs of external monitors to delete
  def delete(test_ids, options={})
    test_ids = test_ids.join(',') if test_ids.class == Array
    args = {testIds: test_ids}.merge(options)
    post('deleteExternalMonitor', args)
  end

  # Suspend an external monitor
  #
  # === Optional arguments
  # Either monitorIds _or_ tag is required
  # * monitorIds - comma separated list of ids of the monitors to suspend
  # * tag - tests with this tag will be suspended
  #
  # === Optional arguments
  def suspend(options={})
    # either monitorIds or tag is required
    # if options is a hash, then treat it as options
    # otherwise, treat it as a monitor id or an array of them
    if options.class == Hash
      result = post('suspendExternalMonitor', options)
    elsif options.class == Array
      result = post('suspendExternalMonitor', monitorIds: options.join(','))
    else
      result = post('suspendExternalMonitor', monitorIds: options)
    end
    result
  end

  # Activate an external monitor
  #
  # === Optional arguments
  # Either monitorIds _or_ tag is required
  # * monitorIds - comma separated list of ids of the monitors to activate
  # * tag - tests with this tag will be activated
  #
  # === Optional arguments
  def activate(options={})
    # either monitorIds or tag is required
    if options.class == Hash
      result = post('activateExternalMonitor', options)
    elsif options.class == Array
      result = post('activateExternalMonitor', monitorIds: options.join(','))
    else
      result = post('activateExternalMonitor', monitorIds: options)
    end
    result
  end

  # Get locations for external monitors
  def locations
    get('locations')
  end

  # List external monitors
  #
  # === Required arguments
  #
  # === Optional arguments
  # * tag - monitors with this tag will be returned
  def monitors(tag=nil)
    # use api call tests if no tag specified
    # use api call tagtests if a tag is specified
    if tag == nil
      result = get('tests')
    else
      result = get('tagtests', tag: tag)
    end
    result
  end

  # Get info for the specified external monitor
  #
  # === Required arguments
  # * test_id - ID of the test to get info for
  #
  # === Optional arguments
  def info(test_id, options={})
    args = {testId: test_id}.merge(options)
    get('testinfo', args)
  end

  # Get results for the specified external monitor
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
  def results(test_id, day, month, year, options={})
    args = {testId: test_id, day: day, month: month, year: year}
           .merge(options)
    get('testresult', args)
  end

  # Get snapshot for the external monitor
  #
  # === Optional arguments
  # * locationIds - comma separated ids of the locations for which results
  #   should be retrieved
  def snapshot(options={})
    get('testsLastValues', options)
  end

  # Get tags for the external monitors
  def tags
    get('tags')
  end

end