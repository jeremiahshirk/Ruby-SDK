class Notification < MonitisClient

  def add_notification_rule(id, type, period, notify_backup, 
                            continuous_alerts, failure_count, 
                            comparing_method, options={})
    args = {
      monitorId: id, monitorType: type, period: period,
      notifyBackup: notify_backup, continuousAlerts: continuous_alerts, 
      failureCount: failure_count, comparingMethod: comparing_method
      }.merge(options)

    addNotificationRule(args)
  end

  def delete_notification_rule(contact_ids, monitor_id, monitor_type)
    contact_ids = contact_ids.join(',') if contact_ids.class == Array
    args = {contactIds: contact_ids, 
            monitorId: monitor_id,
            monitorType: monitor_type}
    deleteNotificationRule(args)
  end

  def notification_rules(id, type)
    getNotificationRules(monitorId: id, monitorType: type)
  end
end