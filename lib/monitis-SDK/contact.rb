class Contact < MonitisClient
   
  def add_contact(first, last, account, type, timezone, options={})
    args = {firstName: first, lastName: last, account: account,
            contactType: type, timezone: timezone}.merge(options)
    addContact(args)
  end

  def delete_contact(*args)
    if args.length == 1
      result = deleteContact(contactId: args.first)
    elsif args.length == 2
      result = deleteContact(account: args[0], contactType: args[1])
    else
      raise "delete contact takes 1 or 2 args"
    end
    result
  end

  def  edit_contact(id, options={})
    args = {contactId: id}.merge(options)
    editContact(args)
  end

  def confirm_contact(id, confirmation_key)
    confirmContact(contactId: id, confirmationKey: confirmation_key)
  end

  def activate_contact(contact_id)
    contactActivate(contactId: contact_id)
  end

  def deactivate_contact(contact_id)
    contactDeactivate(contactId: contact_id)
  end

  def contact_groups()
    contactGroupList
  end

  def contacts()
    contactsList
  end

  def recent_alerts(options={})
    recentAlerts(options)
  end
      
end