trigger AccountTrigger on Account (after insert) {
    // Set account types to 'Prospect' if not already set
    AccountTriggerHandler.setTypeProspectAfterInsert(Trigger.new);

    // Copy shipping addresses to billing addresses where applicable
    AccountTriggerHandler.addressCopyAfterInsert(Trigger.new);

    // Set Rating if Phone, Website, and Fax != null
    AccountTriggerHandler.setRating(Trigger.new);

    // Create default Contact from Account
    AccountTriggerHandler.defaultContact(Trigger.new);
}
