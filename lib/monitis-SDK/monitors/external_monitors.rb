class ExternalMonitors < MonitisClient

  def add(type, name, url, interval, location_ids, tag, options={})
    args = {type: type, name: name, url: url, interval: interval,
            locationIds: location_ids, tag: tag}
            .merge(options)
    addExternalMonitor(args)
  end

  def edit(test_id, name, url, location_ids, timeout, tag, options={})
    args = {testId: test_id, name: name, url: url, locationIds: location_ids,
            timeout: timeout, tag: tag}.merge(options)
    editExternalMonitor(args)
  end

  def delete(test_ids, options={})
    test_ids = test_ids.join(',') if test_ids.class == Array
    args = {testIds: test_ids}.merge(options)
    deleteExternalMonitor(args)
  end

  def suspend(options={})
    # either monitorIds or tag is required
    # if options is a hash, then treat it as options
    # otherwise, treat it as a monitor id or an array of them
    if options.class == Hash
      result = suspendExternalMonitor(options)
    elsif options.class == Array
      result = suspendExternalMonitor(monitorIds: options.join(','))
    else
      result = suspendExternalMonitor(monitorIds: options)
    end
    result
  end

  def activate(options={})
    # either monitorIds or tag is required
    if options.class == Hash
      result = activateExternalMonitor(options)
    elsif options.class == Array
      result = activateExternalMonitor(monitorIds: options.join(','))
    else
      result = activateExternalMonitor(monitorIds: options)
    end
    result
  end

  def locations
    get('locations')
  end

  def monitors(tag=nil)
    # use api call tests if no tag specified
    # use api call tagtests if a tag is specified
    if tag == nil
      result = tests()
    else
      result = tagtests(tag: tag)
    end
    result
  end

  def info(test_id, options={})
    args = {testId: test_id}.merge(options)
    testinfo(args)
  end

  def results(test_id, day, month, year, options={})
    args = {testId: test_id, day: day, month: month, year: year}
           .merge(options)
    testresult(args)
  end

  def snapshot(options={})
    testsLastValues(options)
  end

  def tags
    get('tags')
  end

end