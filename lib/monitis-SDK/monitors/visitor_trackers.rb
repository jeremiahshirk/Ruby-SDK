class VisitorTrackerMonitors < MonitisClient

  def results(site_id, year, month, day, options={})
    args = {siteId: site_id, year: year, month: month, day:day}.merge(options)
    get('visitorTrackingResults', args)
  end

  def info(site_id)
    get('visitorTrackingInfo', {siteId: site_id})
  end

  def monitors
    get('visitorTrackingTests')
  end

  def sites
    get('visitorTrackingTests').collect {|x| x[0]}
  end

end