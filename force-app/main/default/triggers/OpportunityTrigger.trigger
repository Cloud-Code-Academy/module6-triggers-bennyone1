trigger OpportunityTrigger on Opportunity (after insert, after update, before update, before delete, after delete) {
        if (Trigger.isAfter && Trigger.isUpdate) {
            OpportunityTriggerHandler.amountValidation(Trigger.new);
        }
        
        if (Trigger.isBefore && Trigger.isDelete) {
            OpportunityTriggerHandler.deleteCloseWonOpportunity(Trigger.old);
        }        

        if (Trigger.isAfter && Trigger.isUpdate) {
            OpportunityTriggerHandler.setPrimaryContact(Trigger.new);
            System.debug('set pcontact trigger ran');
        }
}
