public with sharing class OpportunityTriggerHandler {

    private static Boolean isTriggerExecuted = false;

    public static void amountValidation(List<Opportunity> updatedOpportunities) {
        for (Opportunity opp : updatedOpportunities) {
            if (opp.Amount < 5000){
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void deleteCloseWonOpportunity(List<Opportunity> oldOpportunities) {
        Set<Id> opportunityIds = new Set<Id>();
        for (Opportunity opp : oldOpportunities) {
            opportunityIds.add(opp.Id);
        }

        List<Opportunity> closedWonOpps = [
            SELECT Id, StageName, AccountId, Account.Industry
            FROM Opportunity
            WHERE StageName = 'Closed Won'
            AND Account.Industry = 'Banking'
            AND Id IN :opportunityIds
            WITH SECURITY_ENFORCED
        ];

        for (Opportunity opp : closedWonOpps) {
            opp.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }

    public static void setPrimaryContact(List<Opportunity> updatedOpportunities) {
        if (isTriggerExecuted) {
            return; 
        }

        isTriggerExecuted = true; 

        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : updatedOpportunities) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Contact> accountIdToPrimaryContactMap = new Map<Id, Contact>();
        for (Contact con : [
            SELECT Id, AccountId, Title 
            FROM Contact 
            WHERE Title = 'CEO' 
            AND AccountId IN :accountIds
            WITH SECURITY_ENFORCED 
        ]) {
            accountIdToPrimaryContactMap.put(con.AccountId, con); 
        }

        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for (Opportunity opp : updatedOpportunities) {
            if (accountIdToPrimaryContactMap.containsKey(opp.AccountId)) {
                Opportunity updatedOpp = new Opportunity(
                    Id = opp.Id, 
                    Primary_Contact__c = accountIdToPrimaryContactMap.get(opp.AccountId).Id
                );
                opportunitiesToUpdate.add(updatedOpp); 
            }
        }

        if (!opportunitiesToUpdate.isEmpty()) {
            update as system opportunitiesToUpdate;
        }
    }
}




