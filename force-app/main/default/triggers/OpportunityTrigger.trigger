trigger OpportunityTrigger on Opportunity ( after update, before delete ) {
        if (Trigger.isAfter && Trigger.isUpdate) {
            OpportunityTriggerHandler.amountValidation(Trigger.new);
            OpportunityTriggerHandler.setPrimaryContact(Trigger.new);
        }
        
        if (Trigger.isBefore && Trigger.isDelete) {
            OpportunityTriggerHandler.deleteCloseWonOpportunity(Trigger.old);
        }        

       
}
