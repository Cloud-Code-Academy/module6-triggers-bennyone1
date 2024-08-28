trigger AccountTrigger on Account (after insert, before insert) {
    // Set account types to 'Prospect' if not already set
    if (Trigger.isInsert && Trigger.isBefore) {
        AccountTriggerHandler.setTypeProspectBeforeInsert(Trigger.new);
        AccountTriggerHandler.addressCopyBeforeInsert(Trigger.new);
        AccountTriggerHandler.setRating(Trigger.new);
    }

    if (Trigger.isInsert && Trigger.isAfter) {
        AccountTriggerHandler.defaultContact(Trigger.new);
    }
}